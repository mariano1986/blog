class UsersController < ApplicationController
  # POST /users
  # POST /users.json

  def create
    @user = User.all
#    @user = User.new(params[:user])
#
#    respond_to do |format|
#      if @user.save
        # Tell the UserMailer to send a welcome Email after save
#        UserMailer.welcome_email(@user).deliver
#
#        format.html { redirect_to(@user, :notice => 'User was successfully created.' )}
#        format.json { render :json => @user, :status => :created, :location => @user }
#      else
#        format.html { render :action => "new" }
#        format.json { render :json => @user.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  def send_mail
    #@user = User.find(params[:id])
    @user = current_user
    #@article = Article.find('12')
    @article = Article.last(10)
    #puts
    #@article.each do |a|
    #  print a.title
    #  puts
    #end
    #puts
    UserMailer.send_articles_email(@user, @article).deliver
    redirect_to articles_path
  end

  def send_mail_sidekiq
    RequestWorker.perform_async
    redirect_to articles_path
  end
end
