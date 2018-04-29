package com.ndw6152.inspiquote;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.ndw6152.inspiquote.Rest.RestClient;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity {
    private String TAG = "mainActivity";

    private Callback updateScreenCallback;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        updateScreenCallback = new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                // TODO on failure what happens
                Log.e(TAG, "Code = error ");
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if (!response.isSuccessful()) {
                    showToast("No quotes from that author");
                }
                else {
                    Log.i(TAG, response.message());
                    try {
                        JSONObject jObject = new JSONObject(response.body().string());
                        String quote = jObject.getString("quote");
                        String author = jObject.getString("author");

                        TextView message = findViewById(R.id.textView_showQuote);
                        updateScreen(message, quote + "\n\n" + "-" + author);
                    }
                    catch (JSONException e) {

                        Log.e(TAG, "Code = error 55");
                    }
                }
            }
        };
    }

    public void updateScreen(final TextView view, final String msg) {
        runOnUiThread(new Thread(new Runnable() {
            public void run() {
                view.setText(msg);
            }
        }));
    }
    private void showToast(final String message) {
        runOnUiThread(new Thread(new Runnable() {
            public void run() {
                Toast.makeText(getApplicationContext(), message, Toast.LENGTH_SHORT).show();
            }
        }));
    }

    public void getQuoteOfTheDayOnClick(View view) {
        RestClient.getQuoteOfTheDay(updateScreenCallback);
    }

    public void getRandomQuoteOnClick(View view) {
        EditText et_authorName = findViewById(R.id.editText_authorName);
        if(et_authorName.getText().toString().length() == 0) {
            showToast("Valid author needed");
        }
        else {
            RestClient.getRandomQuote(et_authorName.getText().toString(), updateScreenCallback);
            View view1 = this.getCurrentFocus();
            if (view1 != null) {
                InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
                assert imm != null;
                imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
            }
        }
    }
}
