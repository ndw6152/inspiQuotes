package com.ndw6152.inspiquote;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.ndw6152.inspiquote.Rest.RestClient;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity {
    private String TAG = "mainActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void updateScreen(final TextView view, final String msg) {
        runOnUiThread(new Thread(new Runnable() {
            public void run() {
                view.setText(msg);
            }
        }));
    }


    public void getQuoteOfTheDayOnClick(View view) {
        RestClient.getQuoteOfTheDay(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                // TODO on failure what happens
                Log.e(TAG, "Code = error ");
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if (!response.isSuccessful()) {
                    Log.e(TAG, "Code = " + response.code() + " " + response.message());
                }
                else {
                    Log.i(TAG, response.message());
                    try {
                        JSONObject jObject = new JSONObject(response.body().string());
                        String quote = jObject.getString("quote");
                        String author = jObject.getString("author");

                        TextView message = findViewById(R.id.textView);
                        updateScreen(message, quote + "\n\n" + "-" + author);
                    }
                    catch (JSONException e) {

                        Log.e(TAG, "Code = error 55");
                    }
                }
            }
        });
    }
}
