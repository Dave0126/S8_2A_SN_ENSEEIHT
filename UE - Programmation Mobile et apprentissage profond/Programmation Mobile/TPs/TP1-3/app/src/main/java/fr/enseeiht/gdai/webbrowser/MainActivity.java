package fr.enseeiht.gdai.webbrowser;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "Browser Activity";
    Button buttonGO;
    EditText editTextURL;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d( TAG, "OnCreate() called!" );
        buttonGO = (Button) findViewById(R.id.button);
        editTextURL = (EditText) findViewById(R.id.editTextTextPersonName);
        buttonGO.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // TODO
                Log.i(TAG, "Button 'GO!' has been pressed");
                Intent skipToURL = new Intent();
                skipToURL.setAction(Intent.ACTION_VIEW);
                skipToURL.setDataAndType(Uri.parse(editTextURL.getText().toString()),"text/html");
                String[] buffer = new String[] {
                        editTextURL.getText().toString()
                };
                Log.i(TAG, String.valueOf(editTextURL.getText()));
                skipToURL.putExtra(Intent.EXTRA_HTML_TEXT,buffer);
                startActivity(skipToURL);
                finish();
            }
        });
    }
}