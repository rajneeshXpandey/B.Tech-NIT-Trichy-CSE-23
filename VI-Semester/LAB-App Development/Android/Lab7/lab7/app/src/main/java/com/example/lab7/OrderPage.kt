package com.example.lab7

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_orderpage.*


class OrderPage : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_orderpage)


        val type=resources.getStringArray(R.array.Type);
        val typeadapter=ArrayAdapter(this,android.R.layout.simple_spinner_item,type);
        typeOfMenu.adapter=typeadapter;


        val drinks=resources.getStringArray(R.array.Drinks);
        val drinkadapter=ArrayAdapter(this,android.R.layout.simple_spinner_item,drinks);
        drinks_spinner.adapter=drinkadapter;

        val starters=resources.getStringArray(R.array.Starters);
        val StartAdapter=ArrayAdapter(this,android.R.layout.simple_spinner_item,starters);
        starters_spinner.adapter=StartAdapter;

        val maindish=resources.getStringArray(R.array.Main);
        val mainadapter=ArrayAdapter(this,android.R.layout.simple_spinner_item,maindish);
        maindish_spinner.adapter=mainadapter;

        val desserts=resources.getStringArray(R.array.Deserts);
        val desAdapter=ArrayAdapter(this,android.R.layout.simple_spinner_item,desserts);
        desserts_spinner.adapter=desAdapter;

        var toSend= mutableListOf<String>();
        toSend.add(typeOfMenu.getSelectedItem().toString());
        toSend.add(drinks_spinner.selectedItem.toString());
        toSend.add(starters_spinner.selectedItem.toString());
        toSend.add(maindish_spinner.selectedItem.toString());
        toSend.add(desserts_spinner.selectedItem.toString());
        var sending=ArrayList(toSend);


        typeOfMenu.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[0]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        drinks_spinner.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[1]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        starters_spinner.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[2]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        maindish_spinner.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[3]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        desserts_spinner.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[4]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        typeOfMenu.onItemSelectedListener =object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                sending[0]=p0?.getItemAtPosition(p2).toString();


            }

            override fun onNothingSelected(p0: AdapterView<*>?) {
            }
        }

        println(sending);

        order_btn.setOnClickListener{
            val myIntent = Intent(this, ResultPage::class.java)
            myIntent.putExtra("Data",sending);
            startActivity(myIntent)
        }

    }
}