require 'csv'

class Back::UsersController < BackController
  before_filter :check_sells_report_params, only: :sells_report
  before_filter :check_views_report_params, only: :views_report

  def index
    @users = User.all
  end

  def newsletter
    @users = User.by_newsletter

    csv_string = CSV.generate do |csv|
      @users.each do |user|
        csv << [
          user.email
        ]
      end
    end
    send_data csv_string, filename: "abonnes-newsletter.csv"
  end

  def show
    @user = User.find(params[:id])
    @bank_detail = @user.bank_detail
  end

  def sells_report
    @orders = Order.date_period(report_params[:start], report_params[:end])
    csv_string = CSV.generate do |csv|
      csv << ['Date création', 'Identifiant œuvre', 'Auteur', 'Acheteur']
      @orders.each do |order|
        order.items.each do |item|
          if !params[:report][:isbn].empty? || !params[:report][:author_id].empty?
            report_params = params[:report]
            next if report_params[:isbn] != item.opus.isbn && !report_params[:isbn].empty?
            next if report_params[:author_id].to_i != item.opus.user_id && !report_params[:author_id].empty?
          end 
          csv << [
            l(order.created_at, format: :short), 
            item.opus.isbn, 
            "#{item.opus.user.firstname} #{item.opus.user.lastname}",
            "#{order.user.firstname} #{order.user.lastname}"
          ]
        end
      end
    end
    send_data csv_string, filename: "#{report_params[:start]}-#{report_params[:end]}-rapport-de-ventes.csv"
  end

  def views_report
    @opuses_logs = OpusLog.select('opuses_logs.*, COUNT(*) as click_count').joins(:opus).where(opuses: {isbn: report_params[:isbn], published: true}).date_period(report_params[:start], report_params[:end]).group('opuses_logs.user_id, DATE(opuses_logs.created_at)')
    @opus     = Opus.find_by_isbn(report_params[:isbn])
    csv_string = CSV.generate do |csv|
      csv << ['Oeuvre (identifiant unique)', 'Artiste', 'Nombre de Clics', 'Date des clics', '"Propriétaire" des clics']
      @opuses_logs.each do |opus_log|
        csv << [
          opus_log.opus.isbn, 
          "#{@opus.user.id} - #{@opus.user.title}",
          opus_log.click_count,
          l(opus_log.created_at, format: :short),
          opus_log.user.title
        ]
      end
    end
    send_data csv_string, filename: "#{report_params[:start]}-#{report_params[:end]}-rapport-de-vues-œuvre-#{report_params[:isbn]}.csv"
  end

  private

  def check_sells_report_params
    redirect_to sells_back_users_path if report_params[:start].empty? && report_params[:end].empty?
  end

  def check_views_report_params
    redirect_to views_back_users_path if report_params[:start].empty? && report_params[:end].empty? && report_params[:isbn].empty?
  end

  def report_params
    params.require(:report).permit(:start, :end, :isbn, :author_id)
  end
end
