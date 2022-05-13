package com.example.lab9;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseException;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthOptions;
import com.google.firebase.auth.PhoneAuthProvider;

import java.util.concurrent.TimeUnit;

public class register extends AppCompatActivity {
    private String verificationId;
    private FirebaseAuth mAuth;

    EditText ph , otp;
    Button verify;
    String phoneNumber ,ot;
    Boolean a = true;

    private PhoneAuthProvider.OnVerificationStateChangedCallbacks
            mCallBacks = new PhoneAuthProvider.OnVerificationStateChangedCallbacks() {

        @Override
        public void onCodeSent(String s, PhoneAuthProvider.ForceResendingToken forceResendingToken) {
            super.onCodeSent(s, forceResendingToken);
            verificationId = s;
        }

        @Override
        public void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
            String code = phoneAuthCredential.getSmsCode();
            if (code != null) {
                otp.setText(code);
                verifyCode(code);
            }
        }

        @Override
        public void onVerificationFailed(FirebaseException e) {
            Toast.makeText(register.this, e.getMessage(), Toast.LENGTH_LONG).show();
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        mAuth = FirebaseAuth.getInstance();

        ph = findViewById(R.id.phone1);
        otp = findViewById(R.id.otp);
        verify = findViewById(R.id.verify);
        if(mAuth.getCurrentUser()!=null){
            Intent intent = new Intent(register.this, profile.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
            startActivity(intent);
        }

        verify.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(a) {
                    phoneNumber = "+91"+ph.getText().toString();
                    if (phoneNumber.isEmpty()) {
                        Toast.makeText(register.this, "Not valid phone No", Toast.LENGTH_SHORT).show();
                    } else {
                        try {
                            sendVerificationCode(phoneNumber);
                            otp.setVisibility(View.VISIBLE);
                            verify.setText("Verify");
                            a=!a;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                }
                else{
                    ot = otp.getText().toString().trim();
                    if (ot.isEmpty() || ot.length() < 6) {
                        Toast.makeText(register.this, "Enter the code", Toast.LENGTH_SHORT).show();;
                    }else {
                        verifyCode(ot);
                    }
                }
            }
        });

    }

    private void verifyCode(String code) {
        PhoneAuthCredential credential = PhoneAuthProvider.getCredential(verificationId, code);
        signInWithCredential(credential);
        Toast.makeText(register.this,credential.toString(),Toast.LENGTH_SHORT).show();
    }

    private void signInWithCredential(PhoneAuthCredential credential) {
        mAuth.signInWithCredential(credential)
                .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {

                            Intent intent = new Intent(register.this, profile.class);
                            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);

                            startActivity(intent);

                        }
                    }
                });
    }



    private void sendVerificationCode(String number) {
        PhoneAuthOptions options =
                PhoneAuthOptions.newBuilder(mAuth)
                        .setPhoneNumber(number)       // Phone number to verify
                        .setTimeout(60L, TimeUnit.SECONDS) // Timeout and unit
                        .setActivity(this)                 // Activity (for callback binding)
                        .setCallbacks(mCallBacks)          // OnVerificationStateChangedCallbacks
                        .build();
        PhoneAuthProvider.verifyPhoneNumber(options);

    }



}