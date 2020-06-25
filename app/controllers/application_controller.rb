class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?


	protected
  def after_sign_in_path_for(resource) #サインインした時の移動先の指定（商品一覧ページ）
    event_user_path(current_user.id)
  end

  
  def after_sign_out_path_for(resource) #サインアウト後の移動先の指定（トップページ指定）
    root_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postcode, :password, :password_confirmation, :prefecture_code, :address_city, :address])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end

end
