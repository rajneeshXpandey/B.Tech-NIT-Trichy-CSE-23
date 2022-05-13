package com.example.lab9;

import android.content.Intent;
import android.os.Bundle;

import com.google.firebase.auth.FirebaseAuth;

import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class profile extends AppCompatActivity {
Button logout;
TextView user;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
        logout = findViewById(R.id.logout);
        user = findViewById(R.id.user);
        String u = FirebaseAuth.getInstance().getCurrentUser().toString();
        user.setText(u);
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                FirebaseAuth.getInstance().signOut();
                Intent i = new Intent(profile.this,register.class);
                startActivity(i);
            }
        });

    }
}