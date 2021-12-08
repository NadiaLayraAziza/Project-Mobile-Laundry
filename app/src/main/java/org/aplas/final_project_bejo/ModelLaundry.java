package org.aplas.final_project_bejo;

import android.os.Parcel;
import android.os.Parcelable;

public class ModelLaundry implements Parcelable {
    public int uid;
    public String nama_jasa;
    public int items;
    public String alamat;
    public int harga;

    protected ModelLaundry(Parcel in) {
        this.uid = in.readInt();
        this.nama_jasa = in.readString();
        this.items = in.readInt();
        this.alamat = in.readString();
        this.harga = in.readInt();
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getNama_jasa() {
        return nama_jasa;
    }

    public void setNama_jasa(String nama_jasa) {
        this.nama_jasa = nama_jasa;
    }

    public int getItems() {
        return items;
    }

    public void setItems(int items) {
        this.items = items;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public int getHarga() {
        return harga;
    }

    public void setHarga(int harga) {
        this.harga = harga;
    }

    public static final Creator<ModelLaundry> CREATOR = new Creator<ModelLaundry>() {
        @Override
        public ModelLaundry createFromParcel(Parcel source) {
            return new ModelLaundry(source);
        }

        @Override
        public ModelLaundry[] newArray(int size) {
            return new ModelLaundry[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.uid);
        dest.writeString(this.nama_jasa);
        dest.writeInt(this.items);
        dest.writeString(this.alamat);
        dest.writeInt(this.harga);
    }
}
