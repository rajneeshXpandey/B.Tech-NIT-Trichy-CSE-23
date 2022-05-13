package com.example.lab10;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.speech.tts.TextToSpeech;
import android.Manifest;
import android.annotation.SuppressLint;
import android.content.pm.PackageManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity implements LocationListener{

    TextToSpeech mTTS;
    Button button_location;
    TextView textView_location;
    LocationManager locationManager;
    String add;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView_location = findViewById(R.id.text_location);
        button_location = findViewById(R.id.button_location);
        //Runtime permissions
        if (ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(MainActivity.this,new String[]{
                    Manifest.permission.ACCESS_FINE_LOCATION
            },100);
        }


        button_location.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //create method
                Log.e("QWERTY", "pressed");
                getLocation();
            }
        });

        mTTS = new TextToSpeech(this, new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    int result = mTTS.setLanguage(Locale.ENGLISH);

                    if (result == TextToSpeech.LANG_MISSING_DATA
                            || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                        Log.e("TTS", "Language not supported");
                    } else {
//                        button_location.setEnabled(true);
                    }
                } else {
                    Log.e("TTS", "Initialization failed");
                }
            }
        });


    }

    private void speak() {
        String text = add;

        mTTS.setPitch(2);
        mTTS.setSpeechRate(2);

        mTTS.speak(text, TextToSpeech.QUEUE_FLUSH, null);
    }


    @SuppressLint("MissingPermission")
    private void getLocation() {

        try {
            locationManager = (LocationManager) getApplicationContext().getSystemService(LOCATION_SERVICE);
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER,5000,5,MainActivity.this);

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @Override
    public void onLocationChanged(Location location) {
        Toast.makeText(this, ""+location.getLatitude()+","+location.getLongitude(), Toast.LENGTH_SHORT).show();
        try {
            Log.e("QWERTY", "a");
            Geocoder geocoder = new Geocoder(MainActivity.this, Locale.getDefault());
            Log.e("QWERTY", "b");
            List<Address> addresses = geocoder.getFromLocation(location.getLatitude(),location.getLongitude(),1);
            Log.e("QWERTY", "c");
            String address = addresses.get(0).getAddressLine(0);
            add = address;

            textView_location.setText(address);

            speak();

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {

    }

    @Override
    public void onProviderEnabled(String provider) {

    }

    @Override
    public void onProviderDisabled(String provider) {

    }
}