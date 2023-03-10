class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数にからのModelオブジェクトを生成する。
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
    # if式を用いて、対象のカラムにデータが入力されていればsaveメソッドでtrueが返される。
    # 詳細画面へリダイレクト
      redirect_to list_path(@list.id)
    else
    # 対象のカラムにデータが入力されていなければ、saveメソッドでfalseが返される
    # falseならば、新規投稿ページを再表示するように設定
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])   # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    redirect_to '/lists'  # 投稿一覧画面へリダイレクト
  end

  private

  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
