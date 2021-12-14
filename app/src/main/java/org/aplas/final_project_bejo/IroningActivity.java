package org.aplas.final_project_bejo;

import static org.aplas.final_project_bejo.CuciBasahActivity.setWindowFlag;

import android.app.Activity;
import android.graphics.Color;
import android.location.Address;
import android.location.Geocoder;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import org.aplas.final_project_bejo.R;
import org.aplas.final_project_bejo.utils.FunctionHelper;
import org.aplas.final_project_bejo.viewmodel.AddDataViewModel;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

public class IroningActivity extends AppCompatActivity {
    public static final String DATA_TITLE = "TITLE";
    int hargaKaos = 3000, hargaCelana = 4000, hargaJaket = 6000, hargaSprei = 0, hargaKarpet = 0;
    int itemCount1 = 0, itemCount2 = 0, itemCount3 = 0;
    int countKaos, countCelana, countJaket, totalItems, totalPrice;
    String strTitle, strCurrentLocation, strCurrentLatLong;
    double strCurrentLatitude;
    double strCurrentLongitude;
    AddDataViewModel addDataViewModel;
    Button btnCheckout;
    ImageView imageAdd1, imageAdd2, imageAdd3, imageAdd4, imageAdd5,
            imageMinus1, imageMinus2, imageMinus3, imageMinus4, imageMinus5;
    TextView tvTitle, tvInfo, tvJumlahBarang, tvTotalPrice, tvKaos, tvCelana, tvJaket, tvSprei, tvKarpet,
            tvPriceKaos, tvPriceCelana, tvPriceJaket, tvPriceSprei, tvPriceKarpet;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_laundry);

    }

    private void setLocation() {

    }

    private void setStatusbar() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        }

        if (Build.VERSION.SDK_INT >= 21) {
            setWindowFlag(this, WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS, false);
            getWindow().setStatusBarColor(Color.TRANSPARENT);
        }
    }


}
