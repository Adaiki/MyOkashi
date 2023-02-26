//
//  ContentView.swift
//  MyOkashi
//
//  Created by 赤荻大輝 on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    //OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    //入力された文字列を保持する状態変数
    @State var inputText = ""
    //SafariViewの表示有無を管理する変数
    @State var showSafari = false
    
    var body: some View {
        VStack {
            //文字を受け取るTextFieldを表示する
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                //入力完了直後に検索する
                okashiDataList.searchOkashi(keyword: inputText)
            }//.onSubmitここまで
            //キーボードの改行を検索に変更する
            .submitLabel(.search)
            //上下左右に空白を空ける
            .padding()
            
            // リストを表示する
            List(okashiDataList.okashiList) { okashi in
                //一つ一つの要素を取り出す
                //ボタンを表示する
                Button {
                    //選択したリンクを保存する
                    okashiDataList.okashiLink = okashi.link
                    //SafariViewを表示する
                    showSafari.toggle()
                } label: {
                    //Listの表示内容を生成する
                    //水平にレイアウト（横方向にレイアウト）
                    HStack {
                        //画像を読み込み、表示する
                        AsyncImage(url: okashi.image) { image in
                            //画像を表示する
                            image
                            //リサイズする
                                .resizable()
                            //アスペクト比を維持してエリア内に収まるようにする
                                .scaledToFit()
                            //高さ40
                                .frame(height: 40)
                        }placeholder: {
                            //読み込み中はインジケーターを表示する
                            ProgressView()
                        }
                        //テキスト表示
                        Text(okashi.name)
                    }//HStackここまで
                }//Butoonここまで
            }//Listここまで
            .sheet(isPresented: $showSafari, content: {
                //SafariViewを表示する
                SafariView(url: okashiDataList.okashiLink!)
                //画面下部がセーフエリア外までいっぱいになるように指定
                    .ignoresSafeArea(edges: [.bottom])
            }//sheetここまで
        )}//VStackここまで
    }//bodyここまで
}//COntentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
