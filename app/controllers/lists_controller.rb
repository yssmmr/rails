class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトをを生成する。
    @list = List.new
  end

  def create
    #1 .&2.データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    #3. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      redirect_to list_path(@list_id)
    #4. 詳細画面へリダイレクト
    else
      render :new
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list =List.find(params[:id])
  end

  def destroy
    list = List.find(params[:id]) #データ（レコード）を一件取得
    list.destroy #データ（レコード）を削除
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title,:body, :image)
  end
end