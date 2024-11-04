import cv2
import numpy as np
import serial
from PIL import Image
import time

video = cv2.VideoCapture('http://192.168.123.214:81/stream')
ser = serial.Serial('COM6', 115200, timeout=1)  # 포트 및 통신 속도를 맞추도록 수정
ser_fpga = serial.Serial('COM14', 115200, timeout=1)  # UART 포트 및 전송 속도 설정 (변경 필요)
i = 0
num = 1
num123 = 1
message = "pass\n"
message2 = "fail\n"
count = 1
file_path = "C:\homepage_log\wafers.txt"

def write_to_file(data):
    with open(file_path, 'w') as file:
        file.write(data)


while True:
    
    
    frame_size = (int(video.get(cv2.CAP_PROP_FRAME_WIDTH)), int(video.get(cv2.CAP_PROP_FRAME_HEIGHT)))
    
        
    received_data = ser_fpga.readline().decode('utf-8').strip()
    if received_data:
            value = ord(received_data[0])
            print(f'받은데이터 : {value}')
            if __name__ == "__main__":
                    message123 = str(value)
                    write_to_file(message123)
                    time.sleep(1)  # Add a delay to simulate real-time updates

            if(value >= 98) :
                print("보냈어")
                ser.write(message.encode('utf-8'))
            else :
                print("보냈어")
                ser.write(message2.encode('utf-8'))
            
            
    response = ser.readline().decode('utf-8', errors='ignore').strip()
    
    ret, frame = video.read()

    if not ret:
        video = cv2.VideoCapture('http://192.168.123.214:81/stream')
        print("문제2 발생")
        continue
    cv2.imshow('ESP32-CAM', frame)
    ret, frame = video.read()



    if response == "capture_trig":
        # 현재 프레임을 이미지로 저장합니다.
        image_name = 'C:\\snapshot.png'
        ret, frame = video.read()
        ret, frame = video.read()
        ret, frame = video.read()
        ret, frame = video.read()
        ret, frame = video.read()
        
        cv2.imwrite(image_name, frame)
        print(f'{image_name}로 스냅샷 저장됨')
        capturing = False  # 사진 촬영 상태를 해제


        image_path = 'C:\\snapshot.png'  # 파일 경로
        image = cv2.imread(image_name)
        height, width, _ = image.shape
    
        # 그레이스케일로 변환
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)




        # 원 검출
        circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, dp=1, minDist=600, param1=250, param2=26, minRadius=120, maxRadius=700)
        if circles is None:
            print(f"원 검출 실패")
            ser.write(message.encode('utf-8'))
        if circles is not None:
            circles = np.uint16(np.around(circles))

            # 결과 이미지 초기화 (흰색으로 채움)
            result2 = np.ones_like(image) * 255
            # 각 원 주위에 동그라미 그리기
            for circle in circles[0, :]:
                center = (circle[0], circle[1])  # 원의 중심 좌표
                radius = circle[2]               # 원의 반지름
                mask = np.zeros_like(image)
                cv2.circle(mask, center, radius, (255, 255, 255), thickness=cv2.FILLED)
                # 원 내부 영역을 흰색으로 채움
            
                result2 = cv2.bitwise_and(result2, mask)
            
                dst = np.ones((height, width, 3), dtype=np.uint8) * 255  # 흰색 (BGR 색상 코드: 255, 255, 255)
                cv2.circle(result2, center, radius, (255, 255, 255), thickness=1)
                cv2.copyTo(image, result2, dst)            
                print(f"동그라미 그리기")

            # 그림자 부분과 개체 부분 분리
            hsv_image = cv2.cvtColor(dst, cv2.COLOR_BGR2HSV)
            v_channel = hsv_image[:, :, 2]
            shadow_mask = v_channel < 110  # 그림자 픽셀을 식별하기 위한 임계값 설
            v_channel[shadow_mask] = v_channel[shadow_mask] + 50  # 그림자 부분을 밝게 조정

            # 색상 경계 유지를 위한 적응적 임계값 설정
            gray_image = cv2.cvtColor(dst, cv2.COLOR_BGR2GRAY)
            binary_image = cv2.adaptiveThreshold(gray_image, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 47, 15)

            # 모폴로지 연산을 위한 구조 요소 (커널) 정의
            kernel = np.ones((3, 3), np.uint8)  # 작은 구조 요소 사용

            # 모폴로지 연산 수행 (열림 연산으로 작은 잡음 제거)
            cleaned_binary_image = cv2.morphologyEx(binary_image, cv2.MORPH_OPEN, kernel)

            # 모폴로지 연산을 위한 구조 요소 (커널) 재정의 (모노폴리 연산을 위한 작은 커널)
            kernel = np.ones((1, 1), np.uint8)

            # 모노폴리 연산 수행 (개체 결합)
            result_image = cv2.dilate(cleaned_binary_image, kernel, iterations=1)


        
            result_image = cv2.cvtColor(result_image, cv2.COLOR_GRAY2BGR)
            gray = cv2.cvtColor(result_image, cv2.COLOR_BGR2GRAY)
            print(f"모폴로지")
        
            height, width, _ = result_image.shape

            # 원 검출
            circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, dp=1, minDist=600, param1=250, param2 = 10, minRadius=100, maxRadius=700)
            if circles is None:
                print(f"원 검출 실패2222")
                ser.write(message.encode('utf-8'))
            if circles is not None:
                circles = np.uint16(np.around(circles))

                # 결과 이미지 초기화 (흰색으로 채움)
                result2 = np.ones_like(result_image) * 255

        
                # 각 원 주위에 동그라미 그리기
                for circle in circles[0, :]:
                    center = (circle[0], circle[1])  # 원의 중심 좌표
                    radius = circle[2]               # 원의 반지름
                    radius2 = int(radius * 0.9)
                    mask = np.zeros_like(result_image)
            
                    cv2.circle(mask, center, radius2, (255, 255, 255), thickness=cv2.FILLED)
                    # 원 내부 영역을 흰색으로 채움
            
            

            
                    dst = np.ones((height, width, 3), dtype=np.uint8) * 255  # 흰색 (BGR 색상 코드: 255, 255, 255)
                    cv2.circle(result2, center, radius, (255, 255, 255), thickness=1)




                
                    cv2.copyTo(result_image, mask, dst)
            

                    # 이미지를 그레이스케일로 변환
                    gray = cv2.cvtColor(dst, cv2.COLOR_BGR2GRAY)

                    # 가우시안 블러 적용 (노이즈 감소)
                    blurred = cv2.GaussianBlur(gray, (3, 3), 0)

                    # 엣지 검출 (Canny 사용)
                    edges = cv2.Canny(blurred, 40, 160)

                    # 윤곽선 검출 (contours)
                    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

                    # 일정 두께 이상의 윤곽선을 그리고 내부를 색칠하기
                    min_thickness = 600
                    for contour in contours:
                        if cv2.arcLength(contour, closed=True) > min_thickness:
                            # 감지한 곡선을 빨간색(0, 0, 255)으로 외곽선을 그리고 내부를 녹색(0, 255, 0)으로 색칠
                            cv2.drawContours(dst, [contour], -1, (0, 0, 255), -1)

                    # 결과 이미지 표시
                    


            
            
            
                height, width, _ = dst.shape

                for y in range(height):
                    for x in range(width):
                        if (dst[y, x] == [0, 0, 0]).all():
                            dst[y, x] = [0, 255, 0]  # 초록색 (BGR 색상 코드)

            

                cv2.circle(dst, center, radius2, (0,0,0), thickness=2)
            

                x = center[0] - radius2-2
                y = center[1] - radius2-2
                side_length = 2 * radius2 + 4


                dst = dst[y:y+side_length, x:x+side_length]

            
                height, width, _ = dst.shape
                mask = np.zeros((height, width), dtype=np.uint8)
                center = (width // 2, height // 2)
                radius = min(width, height) // 2
                cv2.circle(mask, center, radius2, 255, -1)  # -1은 원을 채워 그립니다.

                background_color = (255, 0, 0)  # BGR 색상 코드 (주황색)
                orange_background = np.full((height, width, 3), background_color, dtype=np.uint8)


            
                cv2.copyTo(dst, mask,orange_background)
            
                # 미디언 필터 적용
                denoised_image = cv2.medianBlur(orange_background,5)  # 두 번째 매개변수는 필터 크기입니다

                # 양방향 필터 적용
                denoised_image = cv2.bilateralFilter(denoised_image, 9, 75, 75)  # 두 번째와 세 번째 매개변수는 공간 및 강도 가중치입니다




                
                img_homepage = cv2.resize(denoised_image, (667, 589), interpolation=cv2.INTER_AREA)
                img_resized = cv2.resize(denoised_image, (120, 90), interpolation=cv2.INTER_AREA)

                for x in range(width):
                    for y in range(height):
                        # 각 픽셀의 RGB 값을 가져옵니다
                        b, g, r = img_homepage[y, x]
                        
                        
                        if (r>=200 & g >= 200) | (g>=200 & b >= 200) | (r>=200 & b >= 200) :
                            r = 255
                            g = 255
                            b = 255

                        
        
  
                        elif r >= 200 :
                            r = 255
                            g = 0
                            b = 0
                        elif g >= 200 :
                            r = 0
                            g = 255
                            b = 0
                        elif b >= 200 :
                            r = 0
                            g = 0
                            b = 0
                        
                        else :
                            r = 0
                            g = 0
                            b = 0

                print(f"사진만들기")

                            
                output_path = f'C:\homepage_log\static\crack{num}.png'  # f-string을 사용하여 변수 num을 삽입
                cv2.imwrite(output_path, img_homepage)
                if num == 3:
                    num = 1
                else : num = num + 1
                print(f'Result image saved as {output_path}')
                
            

                height, width, _ = img_resized.shape

                for x in range(width):
                    for y in range(height):
                        # 각 픽셀의 RGB 값을 가져옵니다
                        b, g, r = img_resized[y, x]
                        
                        
                        if (r>=200 & g >= 200) | (g>=200 & b >= 200) | (r>=200 & b >= 200) :
                            r = 255
                            g = 255
                            b = 255

                        
        
  
                        elif r >= 200 :
                            r = 255
                            g = 0
                            b = 0
                        elif g >= 200 :
                            r = 0
                            g = 255
                            b = 0
                        elif b >= 200 :
                            r = 0
                            g = 0
                            b = 0
                        
                        else :
                            r = 0
                            g = 0
                            b = 0

                img_resized = cv2.resize(orange_background, (160, 120), interpolation=cv2.INTER_AREA)

      
            
                # 결과 이미지를 'output.png'로 저장 (C 드라이브에)
                output_path = f'C:\\dst{num123}.png'  # f-string을 사용하여 변수 num을 삽입
                num123 = num123+1
                cv2.imwrite(output_path, img_resized)
                print(f'Result image saved as {output_path}')

                height, width, _ = img_resized.shape

                for x in range(width):
                    for y in range(height):
                        # 각 픽셀의 RGB 값을 가져옵니다
                        b, g, r = img_resized[y, x]
                        
                        
                        if (r>=200 & g >= 200) | (g>=200 & b >= 200) | (r>=200 & b >= 200) :
                            r = 255
                            g = 255
                            b = 255
                        elif r >= 250 :
                            r = 255
                            g = 0
                            b = 0
                        elif g >= 250 :
                            r = 0
                            g = 255
                            b = 0

                        elif b >= 190 :
                            r = 0
                            g = 0
                            b = 0
        
  
                        elif r >= 200 :
                            r = 255
                            g = 0
                            b = 0
                        elif g >= 200 :
                            r = 0
                            g = 255
                            b = 0
                        
                        else :
                            r = 0
                            g = 0
                            b = 0


                        img_resized[y, x] = (b, g, r)

                for y in range(height):
                    for x in range(width):
                        pixel = img_resized[y, x]  # (y, x) 위치의 픽셀 정보를 가져옴
                        b, g, r = pixel  # RGB 값 추출

                        # RGB 값을 한 바이트씩 변환하여 UART로 전송
                        ser_fpga.write(bytes([r]))  # R 값 전송
                        
                        time.sleep(0.00000025)
                        ser_fpga.write(bytes([g]))  # G 값 전송
                        time.sleep(0.00000025)
                        ser_fpga.write(bytes([b]))  # B 값 전송
                        time.sleep(0.00000025)
 
                
        else:
            print("원을 찾지 못했습니다.")
    cv2.destroyAllWindows()
    
