package com.example.lab7

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        btLogin.setOnClickListener{
            val username=etUsername.text.toString();
            val password=etPassword.text.toString();
            if(username=="Rajneesh" && password=="12345")
            {
                Toast.makeText(this,"Valid Credentials",Toast.LENGTH_LONG).show();
                val myIntent = Intent(this, OrderPage::class.java)
                startActivity(myIntent)
            }
            else
            {
                Toast.makeText(this,"invalid Credentials",Toast.LENGTH_LONG).show();
            }
        }



    }
}