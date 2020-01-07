class SignupController < ApplicationController

  require 'payjp'
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

  def index
  end

  def registration
    @user = User.new
  end

  def sms_confirmation
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:l_name] = user_params[:l_name]
    session[:f_name] = user_params[:f_name]
    session[:l_name_kana] = user_params[:l_name_kana]
    session[:f_name_kana] = user_params[:f_name_kana]
    session[:birth_yyyy_id] = user_params[:birth_yyyy_id]
    session[:birth_mm_id] = user_params[:birth_mm_id]
    session[:birth_dd_id] = user_params[:birth_dd_id]
    @user = User.new( #  新規インスタンス作成
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      l_name: session[:l_name],
      f_name: session[:f_name],
      l_name_kana: session[:l_name_kana],
      f_name_kana: session[:f_name_kana],
      birth_yyyy_id: session[:birth_yyyy_id],
      birth_mm_id: session[:birth_mm_id],
      birth_dd_id: session[:birth_dd_id],
      phone_num: "08000000000", #仮に入力
      authentication_num: "1234",
    )
    render '/signup/registration' unless @user.valid?
  end

  def sms_confirmation_sms
    session[:phone_num] = user_params[:phone_num]
    @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    l_name: session[:l_name],
    f_name: session[:f_name],
    l_name_kana: session[:l_name_kana],
    f_name_kana: session[:f_name_kana],
    birth_yyyy_id: session[:birth_yyyy_id],
    birth_mm_id: session[:birth_mm_id],
    birth_dd_id: session[:birth_dd_id],
    phone_num: session[:phone_num],
    authentication_num: "1234",
    )
    render '/signup/sms_confirmation' unless @user.valid?
  end

  def create
    session[:authentication_num] = user_params[:authentication_num]
    @user = User.new(
    nickname: session[:nickname],
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    l_name: session[:l_name],
    f_name: session[:f_name],
    l_name_kana: session[:l_name_kana],
    f_name_kana: session[:f_name_kana],
    birth_yyyy_id: session[:birth_yyyy_id],
    birth_mm_id: session[:birth_mm_id],
    birth_dd_id: session[:birth_dd_id],
    phone_num: session[:phone_num],
    authentication_num: session[:authentication_num],
    )
    if @user.save
      session[:id] = @user.id
      redirect_to new_delivery_info_path
    else
      render '/signup/sms_confirmation_sms'
    end
  end

  def credit_card
  end

  def pay #payjpとCardのデータベース作成を実施します。
    if params['payjp-token'].blank?
      redirect_to action: 'credit_card'
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token']
      )
      @credit_card = CreditCard.new(
        user_id: session[:id],
        customer_id: customer.id,
        card_id: customer.default_card
        )
      if @credit_card.save
        redirect_to action: 'done'
      else
        redirect_to action: 'pay'
      end
    end
  end

  def done #登録流れが終了、signinをす
    sign_in User.find(session[:id]) unless user_signed_in?
  end

private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :l_name,
      :f_name,
      :l_name_kana,
      :f_name_kana,
      :birth_yyyy_id,
      :birth_mm_id,
      :birth_dd_id,
      :phone_num,
      :authentication_num,
    )
  end
end
