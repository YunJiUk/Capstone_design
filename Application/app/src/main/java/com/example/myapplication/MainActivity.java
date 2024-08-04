package com.example.myapplication;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.SystemClock;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.BreakIterator;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {

    int i = 0;

    int s = 0;

    int n1 = 0;

    String s1;

    TextView mTvReceiveData;
    TextView mTvReceiveData2;
    TextView mTvSendData;
    TextView mTvSendData2;

    ImageView mBtnConnect;
    ImageView mBtnOn;

    ImageView mBtnStop;

    ImageView mImagefoup1 = null;

    ImageView mImagefoup2;

    ImageView mImagefoup3;
    Button mBtnSendData;
    Button mBtnSendData2;

    BluetoothAdapter mBluetoothAdapter;
    Set<BluetoothDevice> mPairedDevices;
    List<String> mListPairedDevices;

    Handler mBluetoothHandler;
    ConnectedBluetoothThread mThreadConnectedBluetooth;
    BluetoothDevice mBluetoothDevice;
    BluetoothSocket mBluetoothSocket;





    final static int BT_REQUEST_ENABLE = 1;
    final static int BT_MESSAGE_READ = 2;
    final static int BT_CONNECTING_STATUS = 3;
    final static UUID BT_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        mTvReceiveData = (TextView) findViewById(R.id.tvReceiveData);
        mTvReceiveData2 = (TextView) findViewById(R.id.tvReceiveData2);
        mTvSendData = (EditText) findViewById(R.id.tvSendData);
        mTvSendData2 = (EditText) findViewById(R.id.tvSendData2);


        mImagefoup1 = (ImageView) findViewById(R.id.Imagefoup1);
        mImagefoup2 = (ImageView) findViewById(R.id.Imagefoup2);
        mImagefoup3 = (ImageView) findViewById(R.id.Imagefoup3);


        mBtnConnect = (ImageView) findViewById(R.id.btnConnect);
        mBtnOn = (ImageView) findViewById(R.id.btnOn);
        mBtnStop = (ImageView) findViewById(R.id.btnStop);
        mBtnSendData = (Button) findViewById(R.id.btnSendData);
        mBtnSendData2 = (Button) findViewById(R.id.btnSendData2);

        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();


        mBtnConnect.setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View view) {
                listPairedDevices();
            }
        });

        mBtnOn.setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (i == 0) {
                    mBtnOn.setImageResource(R.drawable.on);
                    Toast.makeText(getApplicationContext(), "작업을 진행합니다", Toast.LENGTH_SHORT).show();
                    i = 1;
                    if (mThreadConnectedBluetooth != null) {

                        mThreadConnectedBluetooth.write("on\n".toString());

                    }
                }
                if (i == 1) {
                    Toast.makeText(getApplicationContext(), "작업이 진행중입니다.", Toast.LENGTH_SHORT).show();
                }
            }
        });

        mBtnStop.setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(getApplicationContext(), "작업을 긴급 정지합니다", Toast.LENGTH_SHORT).show();
                if (mThreadConnectedBluetooth != null) {

                    mThreadConnectedBluetooth.write("stop\n".toString());
                    if (i == 1) {
                        mBtnOn.setImageResource(R.drawable.off);
                        i = 0;
                    }

                }
            }
        });


        mBtnSendData.setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mThreadConnectedBluetooth != null) {
                    s1 = mTvSendData.getText().toString();
                    if (!s1.equals("")) {
                        mTvSendData.setFocusable(false);
                        mTvSendData.setClickable(false);
                        Toast.makeText(getApplicationContext(), "이제 목표 Wafer 위치를 입력해주세요", Toast.LENGTH_SHORT).show();
                        n1 = 1;
                    }
                }
            }
        });

        mBtnSendData2.setOnClickListener(new Button.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (n1 == 1) {
                    if (mThreadConnectedBluetooth != null) {
                        mTvSendData.setClickable(true);
                        mTvSendData.setFocusableInTouchMode(true);
                        mThreadConnectedBluetooth.write(mTvSendData.getText().toString() + mTvSendData2.getText().toString() + "\n");
                        mBtnOn.setImageResource(R.drawable.on);
                        i = 1;
                        mTvSendData2.setText("");
                        mTvSendData.setText("");
                        n1 = 0;
                    }
                } else if (n1 == 0) {
                    Toast.makeText(getApplicationContext(), "옮길 wafer 위치를 먼저 입력해 주세요", Toast.LENGTH_SHORT).show();

                    mTvSendData.setClickable(true);
                    mTvSendData.setFocusableInTouchMode(true);
                }

            }
        });
        mBluetoothHandler = new Handler() {
            @SuppressLint("HandlerLeak")
            public void handleMessage(android.os.Message msg) {
                if (msg.what == BT_MESSAGE_READ) {
                    byte[] byteArray = (byte[]) msg.obj;
                    String readMessage = null;

                    try {
                        readMessage = new String(byteArray, "UTF-8");
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }


                    Log.d("ReadMessage", "readMessage: " + readMessage); // Log를 추가하여 값을 확인
                    if (readMessage.charAt(0) == 'o') {
                        mBtnOn.setImageResource(R.drawable.off);
                        Toast.makeText(getApplicationContext(), "작업이 모두 완료되었습니다.", Toast.LENGTH_SHORT).show();
                        i = 0;
                    } else if (readMessage.charAt(0) == '1' || readMessage.charAt(0) == '0') {
                        if (readMessage.charAt(0) == '1') {
                            if (readMessage.charAt(1) == '1') {
                                if (readMessage.charAt(2) == '1') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_111);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '0') {
                            if (readMessage.charAt(1) == '1') {
                                if (readMessage.charAt(2) == '1') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_011);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '1') {
                            if (readMessage.charAt(1) == '0') {
                                if (readMessage.charAt(2) == '1') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_101);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '0') {
                            if (readMessage.charAt(1) == '0') {
                                if (readMessage.charAt(2) == '1') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_001);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '1') {
                            if (readMessage.charAt(1) == '1') {
                                if (readMessage.charAt(2) == '0') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_110);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '0') {
                            if (readMessage.charAt(1) == '1') {
                                if (readMessage.charAt(2) == '0') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_010);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '1') {
                            if (readMessage.charAt(1) == '0') {
                                if (readMessage.charAt(2) == '0') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_100);
                                }
                            }
                        }
                        if (readMessage.charAt(0) == '0') {
                            if (readMessage.charAt(1) == '0') {
                                if (readMessage.charAt(2) == '0') {
                                    mImagefoup1.setImageResource(R.drawable.foup1_000);
                                }
                            }
                        }
                        if (readMessage.charAt(3) == '1') {
                            if (readMessage.charAt(4) == '1') {
                                mImagefoup2.setImageResource(R.drawable.foup2_11);
                            }
                        }
                        if (readMessage.charAt(3) == '0') {
                            if (readMessage.charAt(4) == '1') {
                                mImagefoup2.setImageResource(R.drawable.foup2_01);
                            }
                        }
                        if (readMessage.charAt(3) == '1') {
                            if (readMessage.charAt(4) == '0') {
                                mImagefoup2.setImageResource(R.drawable.foup2_10);
                            }
                        }
                        if (readMessage.charAt(3) == '0') {
                            if (readMessage.charAt(4) == '0') {
                                mImagefoup2.setImageResource(R.drawable.foup2_00);
                            }
                        }

                        if (readMessage.charAt(5) == '1') {
                            if (readMessage.charAt(6) == '1') {
                                mImagefoup3.setImageResource(R.drawable.foup2_11);
                            }
                        }
                        if (readMessage.charAt(5) == '0') {
                            if (readMessage.charAt(6) == '1') {
                                mImagefoup3.setImageResource(R.drawable.foup2_01);
                            }
                        }
                        if (readMessage.charAt(5) == '1') {
                            if (readMessage.charAt(6) == '0') {
                                mImagefoup3.setImageResource(R.drawable.foup2_10);
                            }
                        }
                        if (readMessage.charAt(5) == '0') {
                            if (readMessage.charAt(6) == '0') {
                                mImagefoup3.setImageResource(R.drawable.foup2_00);
                            }
                        }
                        readMessage = null;
                    } else if (readMessage.charAt(0) == 'T') {
                        mTvReceiveData.setText(readMessage.substring(4, 6) + "." + readMessage.substring(6, 7) + "°C");
                        mTvReceiveData2.setText(readMessage.substring(1, 3) + "." + readMessage.substring(3, 4) + "%");
                        readMessage = null;
                    }
                }
            }
        };
    }

    void bluetoothOn() {
        if (mBluetoothAdapter == null) {
            Toast.makeText(getApplicationContext(), "블루투스를 지원하지 않는 기기입니다.", Toast.LENGTH_LONG).show();
        } else {
            if (mBluetoothAdapter.isEnabled()) {
                Toast.makeText(getApplicationContext(), "블루투스가 이미 활성화 되어 있습니다.", Toast.LENGTH_LONG).show();
                BreakIterator mTvBluetoothStatus = null;
                mTvBluetoothStatus.setText("활성화");
            } else {
                Toast.makeText(getApplicationContext(), "블루투스가 활성화 되어 있지 않습니다.", Toast.LENGTH_LONG).show();
                Intent intentBluetoothEnable = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
                startActivityForResult(intentBluetoothEnable, BT_REQUEST_ENABLE);
            }
        }
    }

    void bluetoothOff() {
        if (mBluetoothAdapter.isEnabled()) {
            if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            mBluetoothAdapter.disable();
            Toast.makeText(getApplicationContext(), "블루투스가 비활성화 되었습니다.", Toast.LENGTH_SHORT).show();
            BreakIterator mTvBluetoothStatus = null;
            mTvBluetoothStatus.setText("비활성화");
        }
        else {
            Toast.makeText(getApplicationContext(), "블루투스가 이미 비활성화 되어 있습니다.", Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        switch (requestCode) {
            case BT_REQUEST_ENABLE:
                if (resultCode == RESULT_OK) { // 블루투스 활성화를 확인을 클릭하였다면
                    Toast.makeText(getApplicationContext(), "블루투스 활성화", Toast.LENGTH_LONG).show();
                } else if (resultCode == RESULT_CANCELED) { // 블루투스 활성화를 취소를 클릭하였다면
                    Toast.makeText(getApplicationContext(), "취소", Toast.LENGTH_LONG).show();
                }
                break;
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    void listPairedDevices() {
        if (mBluetoothAdapter.isEnabled()) {
            if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            mPairedDevices = mBluetoothAdapter.getBondedDevices();

            if (mPairedDevices.size() > 0) {
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("장치 선택");

                mListPairedDevices = new ArrayList<String>();
                for (BluetoothDevice device : mPairedDevices) {
                    mListPairedDevices.add(device.getName());
                    //mListPairedDevices.add(device.getName() + "\n" + device.getAddress());
                }
                final CharSequence[] items = mListPairedDevices.toArray(new CharSequence[mListPairedDevices.size()]);
                mListPairedDevices.toArray(new CharSequence[mListPairedDevices.size()]);

                builder.setItems(items, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int item) {
                        connectSelectedDevice(items[item].toString());
                    }
                });
                AlertDialog alert = builder.create();
                alert.show();
            } else {
                Toast.makeText(getApplicationContext(), "페어링된 장치가 없습니다.", Toast.LENGTH_LONG).show();
            }
        }
        else {
            Toast.makeText(getApplicationContext(), "블루투스가 비활성화 되어 있습니다.", Toast.LENGTH_SHORT).show();
        }
    }

    void connectSelectedDevice(String selectedDeviceName) {
        for (BluetoothDevice tempDevice : mPairedDevices) {
            if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            if (selectedDeviceName.equals(tempDevice.getName())) {
                mBluetoothDevice = tempDevice;
                break;
            }
        }
        try {
            if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            mBluetoothSocket = mBluetoothDevice.createRfcommSocketToServiceRecord(BT_UUID);
            mBluetoothSocket.connect();
            mThreadConnectedBluetooth = new ConnectedBluetoothThread(mBluetoothSocket);
            mThreadConnectedBluetooth.start();
            mBluetoothHandler.obtainMessage(BT_CONNECTING_STATUS, 1, -1).sendToTarget();
        } catch (IOException e) {
            Toast.makeText(getApplicationContext(), "블루투스 연결 중 오류가 발생했습니다.", Toast.LENGTH_LONG).show();
        }
    }

    private class ConnectedBluetoothThread extends Thread {
        private final BluetoothSocket mmSocket;
        private final InputStream mmInStream;
        private final OutputStream mmOutStream;

        public ConnectedBluetoothThread(BluetoothSocket socket) {
            mmSocket = socket;
            InputStream tmpIn = null;
            OutputStream tmpOut = null;

            try {
                tmpIn = socket.getInputStream();
                tmpOut = socket.getOutputStream();
            } catch (IOException e) {
                Toast.makeText(getApplicationContext(), "소켓 연결 중 오류가 발생했습니다.", Toast.LENGTH_LONG).show();
            }

            mmInStream = tmpIn;
            mmOutStream = tmpOut;
        }
        public void run() {
            byte[] buffer = new byte[1024];
            int bytes;

            while (true) {
                try {
                    bytes = mmInStream.available();
                    if (bytes != 0) {
                        SystemClock.sleep(100);
                        bytes = mmInStream.available();
                        bytes = mmInStream.read(buffer, 0, bytes);
                        mBluetoothHandler.obtainMessage(BT_MESSAGE_READ, bytes, -1, buffer).sendToTarget();
                    }
                } catch (IOException e) {
                    break;
                }
            }
        }
        public void write(String str) {
            byte[] bytes = str.getBytes();
            try {
                mmOutStream.write(bytes);
            } catch (IOException e) {
                Toast.makeText(getApplicationContext(), "데이터 전송 중 오류가 발생했습니다.", Toast.LENGTH_LONG).show();
            }
        }
        public void cancel() {
            try {
                mmSocket.close();
            } catch (IOException e) {
                Toast.makeText(getApplicationContext(), "소켓 해제 중 오류가 발생했습니다.", Toast.LENGTH_LONG).show();
            }
        }
    }
}