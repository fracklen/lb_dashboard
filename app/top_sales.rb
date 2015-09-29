require 'erubis'

class TopSales < Sinatra::Application
  get '/top-sales' do
    @sales = DealStatsService.aggregate
    @users = UserService.by_user_id
    content_type 'text/html'
    status 200
    body erb(:top_sales)
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
