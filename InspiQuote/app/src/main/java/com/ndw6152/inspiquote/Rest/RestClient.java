package com.ndw6152.inspiquote.Rest;

import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;

/**
 * Created by ndw6152 on 4/28/2018.
 */

public class RestClient {
    private static String TAG = "RestClient";
    private static OkHttpClient client = new OkHttpClient();

    private static String URI_BASE ="http://192.168.86.49:5000";
    private static String quote = "/quote";


    private static void GET(String url, Callback responseCallback) {
        Request request = new Request.Builder()
                .url(url)
                .build();
        client.newCall(request).enqueue(responseCallback);
    }

    //
    public static void getQuoteOfTheDay(Callback responseCallback) {
        String url = RestClient.URI_BASE + quote;
        RestClient.GET(url, responseCallback);
    }
}
