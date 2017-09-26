class HomeController < ApplicationController
  def index
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
    #작성하는 창과 작성 리스트
    Day.all.each do |day|
      if day.panelties.first.nil?
        day.destroy
      end
    end
    
    @count = 0
    @month_day= Day.all
    @panelty = Panelty.all
    @user_info = User.all
    @study_info = Post.all
    
    # 벌금 총합
    @total_money = @panelty.sum("money")
    @total_receive = @panelty.where(status: 1).sum("money")
    
  end
  
  def write
    #글 쓰면 날아오는 곳
    # 문태가 반복문으로 해도 된다했는데
   
    
    m = Day.new
    m.month = params[:month] #월
    m.day = params[:day] #날짜
    m.day_written_by = params[:day_written_by]
    m.total = 0
    m.receive = 0
    m.save
    
    
    
    
    
    redirect_to "/home/pay"
  end
  
  def comment
    # p = Panelty.new
    # # p.name = params[:name0], params[:name1], params[:name2], params[:name3], params[:name4], params[:name5]
     
    # p.money0 = params[:money0]
    # p.money1 = params[:money1]
    # p.money2 = params[:money2]
    # p.money3 = params[:money3]
    # p.money4 = params[:money4]
    # p.money5 = params[:money5]
    
    count = params[:count]
    
    
    count.to_i.times do |i| #count만큼 반복 i는 0 ~ count-1
      p = Panelty.new  
      p.name = params[:"name#{i}".to_sym]
      p.money = params[:"money#{i}".to_sym]
      p.status = 0
      p.day_id = params[:day_id]
      
      
      p.save
    end
    
    
    # p.save
    
    redirect_to "/home/index"
  end
  
  
  def board
    b = Post.new
    b.title = params[:title]
    b.content = params[:content]
    b.save
    redirect_to "/"
  end
  
  def pay
    @month_day= Day.all
  end
  
  def update
    one_day = Day.find(params[:id])

    one_panelty_id = one_day.panelties.first.id  # 해당 날짜에 첫번째 벌금항목의 id
    people_count = one_day.panelties.size  # 해당 날짜의 벌금항목 수
    people_count.times do |i|
      one_panelty = Panelty.find(one_day.panelties.first.id + i)
      submit_status = params[:"status#{i}".to_sym]
      # if one_panelty.status == 0 && submit_status == 1
      #   one.day.receive += one_person.money
      # elsif one_panelty.status == 1 && submit_status == 0
      #   one.day.receive -= one_person.money
      # end
      one_panelty.status = submit_status   # 각각 status 업데이트
      one_panelty.save
      # if one_panelty.status == 1
        
      # end
    end
    
    # people_count.times do |i|
    #   one_person = one_day.panelties.find(one_panelty_id + i)  # 각각 벌금 항목에 대해서
    #   if one_person.status == 1  # 그 벌금항목의 상태가 1(벌금제출)이면
    #     one_day.receive += one_person.money  # 벌금항목의 금액만큼 해당날짜의 reveive에 더해줌
    #   # elsif one_person.status == 0
    #   #   one_day.receive -= one_person.money
    #   end
    #   one_day.save  # receive값 저장
    # end
    # one_day.total = one_day.receive
    
    redirect_to '/'
  end
  
  def destroy
    one_day = Day.find(params[:id])
    one_day.destroy
    redirect_to '/'
  end
end
