import ddf.minim.*;
import java.io.File;

Minim minim;
AudioPlayer player;

String text = "";
StringBuilder sb = new StringBuilder();

String dispText = "準備OK";

void setup() {
  size(640, 480);
  PFont font = createFont("HiraginoSans-W4", 30);
  textFont(font);
  textAlign(CENTER);

  minim = new Minim(this);
}

void draw() {
  if (text.length() > 0) {
    // QRコードを読み取ったときの処理
    playMusic(text);
    text = "";
  }
  
  background(255);
  fill(0);
  text(dispText, 320, 240);
}

void keyPressed() {
  if (key == '\n') {
    text = sb.toString();
    sb.setLength(0);
  } else {
    //println((int)key); // 読み取り結果がおかしいときはコメントアウトを外す
    if (key != 65535) { // ASCIIコードが65535の文字が入ってくることがあるのでスキップ
      sb.append(key);
    }
  }
}

void playMusic(String text) {
  String filePath = sketchPath() + "/" + text;
  File file = new File(filePath);
  println("File Path: " + filePath);

  if (!file.exists()) {
    println("file not found");
    dispText = "ファイルが存在しません\n" + text;
  } else {
    if (player instanceof AudioPlayer && player.isPlaying()) {
      // 再生中にQRコードを読み込んだら、すでに流れている曲を停止する処理
      println("stop to play music");
      player.pause();
    }

    println("start to play music");
    player = minim.loadFile(filePath);
    player.play();
    dispText = "音楽ファイルを再生\n" + text;
  }
}
