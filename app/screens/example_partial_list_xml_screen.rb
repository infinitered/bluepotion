class ExamplePartialListXML < PMScreen
  xml_layout :embedded_listview
  title "View with a ListView Inside"

  def on_load
    @list_adapter = PMBaseAdapter.new
    @list_adapter.screen = self
    list_view = find!(:embedded_listview)

    list_view.adapter = @list_adapter
  end


end

# class HomeScreen < PMScreen
#   xml_layout :home_screen
#   action_bar true
#   title "FourPlay Football"
#   stylesheet HomeScreenStylesheet

#   def on_load
#     Session.instance.close_league
#     @list_adapter = HomeScreenListAdapter.new
#     @list_adapter.screen = self
#     list_view = find!(:list_view)

#     @list_adapter.load_async do
#       list_view.adapter = @list_adapter
#     end
#   end

#   def on_appear
#   end
# end

class HomeScreenListAdapter < PMBaseAdapter
  def initialize
    super
  end

  def load_async(&block)
    Client.my_league_teams do |status, results|
      #stop_refreshing
      case status
      when :valid
        league_teams = results[:league_teams]
        @nfl_teams = league_teams.select{|o| o.league.level == :nfl}
        @college_teams = league_teams.select{|o| o.league.level == :ncaafb}

        @data = []

        @data << { layout: :tb_section_header, data: "MY NFL TEAMS" }
        @nfl_teams.each do |team|
          @data << { layout: :home_screen_cell, data: team }
        end

        @data << { layout: :tb_section_header, data: "MY COLLEGE TEAMS" }
        @college_teams.each do |team|
          @data << { layout: :home_screen_cell, data: team }
        end

        @data << { layout: :home_screen_footer_cell }

        block.call
      when :application_error
        # TODO: display an error
      when :server_error
        # TODO: display an error
      end
    end
  end

  def count
    @data.length
  end

  def view_type_count
    3
  end

  def item_view_type_id(position)
    [:home_screen_cell, :tb_section_header, :home_screen_footer_cell].index(@data[position][:layout])
  end

  def view(position, convert_view, parent)
    item_data = @data[position]
    layout_name = item_data[:layout]

    convert_view = convert_view || create_view(item_data)
    update_convert_view(convert_view, item_data)
    convert_view
  end

  def create_view(item_data)
    new_view_q = nil
    layout_name = item_data[:layout]
    new_view_q = screen.create(layout_name)

    case layout_name
    when :home_screen_cell
      new_view_q.on(:tap) do
        Session.instance.league_team = item_data[:data]
        @screen.open MyPicksScreen, activity: PMMenuActivity
      end
    when :home_screen_footer_cell
      new_view_q.find(:how_to_play_button).on(:tap) do
        @screen.open InternalBrowserScreen, named_page: :how_to_play
      end
      new_view_q.find(:create_this_league_button).on(:tap) do
        @screen.open CreateLeagueStartScreen, activity: CreateALeagueActivity
      end

    #when :tb_section_header
    end

    new_view_q.get
  end

  def update_convert_view(convert_view, item_data)
    case item_data[:layout]
    when :home_screen_cell
      league_team = item_data[:data]

      viewq = find(convert_view)
      viewq.find(:team_name_label).data(league_team.name)
      viewq.find(:team_league_label).data(league_team.league.name)
      viewq.find(:team_points_label).data("#{'+' if league_team.points > 0}#{league_team.points.to_s}")
    when :home_screen_footer_cell
    when :tb_section_header
      find(convert_view).find(:tb_header_label).data(item_data[:data])
    end
  end

end

