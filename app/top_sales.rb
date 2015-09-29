require 'erubis'

class TopSales < Sinatra::Application
  helpers do
    def h(text)
      text.gsub("\n", '').gsub("\"", '\"')
    end
  end

  get '/top-sales.html' do
    @sales = DealStatsService.aggregate
    @users = UserService.by_user_id
    content_type 'text/html'
    status 200
    body erb(:top_sales)
  end

  get '/top-sales.json' do
    @sales = DealStatsService.aggregate
    @users = UserService.by_user_id
    content_type 'application/json'
    status 200
    body erb(:top_sales_json)
  end

  get '/users' do
    content_type 'application/json'
    status 200
    body PipedriveClient.users.to_json
  end

  get '/users/:id/image' do
    redirect PipedriveClient.user(params[:id])['icon_url'], 302
  end
end
