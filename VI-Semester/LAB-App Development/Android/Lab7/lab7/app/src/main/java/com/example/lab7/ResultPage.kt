package com.example.lab7

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_result.*

class ResultPage : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_result)
        val got = intent.getStringArrayListExtra("Data");
       if(got!=null)
       {
           val v0=got[0];
            val v1=got[1];
           val v2=got[2];
           val v3=got[3];
           val v4=got[4];
           tvresult.text="Your Order is $v0 , $v1  $v2 , $v3 , $v4 "

       }





    }
}