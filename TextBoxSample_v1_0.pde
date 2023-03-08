/*
// 【TextBoxSample_v1.0】

// テキストボックスの表示と入力文字列を取得するプログラム
// 入力結果を実行画面中央に表示する

// 谷中俊介 YANAKA Shunsuke
// 2023年 3月 4日
*/

//----------------------------------------------------------------------------------------------------
// ライブラリ
//---------------------------------------------------------------------------------------------------- 
// テキストボックス用のライブラリ
import javax.swing.*;
import java.awt.*;

//----------------------------------------------------------------------------------------------------
// グローバル変数・オブジェクトの宣言
//----------------------------------------------------------------------------------------------------
// 全般
int windowWidth = 640;  // 実行画面の幅
int windowHeight = 480;  // 実行画面の高さ
int fps = 30;  // 実行フレームレート

// テキストボックス
JLayeredPane pane;
JPanel panel;
JTextField textbox;
int textBoxWidth = 480;  // テキストボックスのウィンドウの幅
int textBoxHeight = 100;  // テキストボックスのウィンドウの高さ
int responseTextWindow = -1;  // テキストボックスからの返り値（0:OK, 2:取消, -1:ウィンドウを閉じる）
String inputText = "";  // テキストボックスで入力した文字列を格納するための変数

//----------------------------------------------------------------------------------------------------
// 初期化処理
//----------------------------------------------------------------------------------------------------
void settings() {
  size(windowWidth, windowHeight);  // Processing3.x系では，実行画面の大きさを変数で指定する場合，
                                    // setup()関数でなく，settings()関数を用いる必要がある
}

void setup() {
  // SmoothCanvasの親の親にあたるJLayeredPaneを取得
  Canvas canvas = (Canvas) surface.getNative();
  pane = (JLayeredPane) canvas.getParent().getParent();
  
  // テキストボックス用のウィンドウ
  panel = new JPanel();
  panel.setPreferredSize(new Dimension(textBoxWidth, textBoxHeight));  // テキストボックス用のウィンドウのサイズを指定
  BoxLayout layout = new BoxLayout(panel, BoxLayout.Y_AXIS);
  panel.setLayout(layout);
  panel.add(new JLabel("<html><span style='font-size:16px'>任意の文字列を入力してください<br>※全角/半角は問いません</span></html>"));
  
  // テキストボックス
  textbox = new JTextField();
  textbox.setFont(new Font( "MS Gothic", Font.PLAIN, 24));  // テキストボックスにおけるフォントの設定
  panel.add(textbox);
  
  // テキストボックスのウィンドウの生成
  responseTextWindow = JOptionPane.showConfirmDialog(null, panel, "テキストボックスのタイトル", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
    
  // テキストボックスのウィンドウに対し行われた入力への対処
  switch(responseTextWindow) {
      case 0:  // テキストボックスで「OK」ボタンが押された場合
        inputText = textbox.getText();  // テキストボックスへの入力値を取得  
        if(inputText.equals("") ){  // 文字列の入力をせず「OK」ボタンが押された場合の処理
          inputText = "未入力";
        } 
        break;
      case 2:  // テキストボックスで「取消」ボタンが押された場合
        inputText = "入力が取り消されました";
        break;
      case -1: // テキストウィンドウの「×」ボタンでウィンドウが閉じられた場合
        inputText = "ウィンドウが閉じられました";
        break;   
  }

  background(0);   // 背景を黒に設定
  frameRate(fps);  // フレームレートを設定

  // 実行画面上のフォントの設定
  PFont font = createFont("MS Gothic", 48, true);  // createFont(設定するフォント, フォントサイズ, 文字を滑らかにするか否か)
  textFont(font);  // この処理により, text() で表示する文字を全て設定したフォントにする
}

//----------------------------------------------------------------------------------------------------
// 描画処理
//----------------------------------------------------------------------------------------------------
void draw() {
  background(0);   // 背景色で塗りつぶす
  
  fill(255);  // 文字の色
  textAlign(CENTER);  // textの指定座標を文字列の中心にする
  text(inputText, windowWidth/2, windowHeight/2);  // テキストボックスに入力した文字列を実行画面の中央に表示する
}
