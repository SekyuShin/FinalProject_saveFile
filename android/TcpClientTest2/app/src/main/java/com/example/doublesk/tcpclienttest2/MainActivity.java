package com.example.doublesk.tcpclienttest2;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;

public class MainActivity extends AppCompatActivity {
    //private  String ip = "192.168.219.100"; // IP
    //private int port = 3000; // PORT번호
    private String ip = "13.125.131.249";
    private int port = 80;
    Handler msgHandler; //android.os.handler
    SocketClient client;
    ReceiveThread receive;
    SendThread send;
    Socket socket;
    TextView textView;
    Button button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = (TextView)findViewById(R.id.textView);
        button = (Button)findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                client = new SocketClient(ip,port);
                client.start();
                Log.d("Tag","client.isAlive() : "+client.isAlive());

            }
        });

        msgHandler = new Handler() {
            @Override
            public void handleMessage(Message msg) {
                if(msg.what == 1111) {
                    Log.d("Tag","msg : "+msg.obj.toString());
                    textView.setText(msg.obj.toString()+'\n');
                    try {
                        Log.d("Tag","client : "+client.isAlive());
                        Log.d("Tag","send : "+send.isAlive());
                        Log.d("Tag","revieve : "+receive.isAlive());
                        socket.close();
                    }catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        };
    }
    private class SocketClient extends Thread{
        boolean threadAlive;
        String ip;
        int port;
        //DataOutputStream output = null;
        public SocketClient(String ip, int port) {
            this.ip = ip;
            this.port = port;
            threadAlive = true;
        }

        @Override
        public void run() {
            super.run();
            try {
                socket = new Socket(ip,port);
                send = new SendThread(socket);
                send.start();
                Log.d("Tag","send.isAlive() : "+send.isAlive());
                receive = new ReceiveThread(socket);
                receive.start();
            }catch(Exception e) {
                e.printStackTrace();
            }
        }
    }

    private class ReceiveThread extends Thread{
        Socket socket = null;
        BufferedReader in;
        boolean isAlive ;
        public ReceiveThread(Socket socket) {
            this.socket = socket;
            isAlive = true;
            try {
                in= new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            } catch(Exception e) {
                e.printStackTrace();
            }

        }

        @Override
        public void run() {
            super.run();
            try {
                //while(in!=null){

                        String msg = in.readLine();

                    //if(msg != null) {
                        Message _msg =msgHandler.obtainMessage();
                        _msg.what = 1111;
                        _msg.obj = msg;
                        msgHandler.sendMessage(_msg);
                    //}

                //}



            } catch(Exception e1) {
            e1.printStackTrace();
        }
        }
    }
    private class SendThread extends Thread{
        Socket socket;
        String sendmsg = "Ardroid";
        PrintWriter out;
        public SendThread(Socket socket) {
            this.socket = socket;
            try {
                out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(this.socket.getOutputStream())),true);
            }catch(Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void run() {
            super.run();
            try {
                Log.d("Tag","sendMsg : "+sendmsg);
                    out.print(sendmsg);
                    out.flush();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
    }



}
