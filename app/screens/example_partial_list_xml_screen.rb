# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  This screen shows partial list views, both in a screen and in a dialog.
#  This screen also shows pull to refresh
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

class ExamplePartialListXML < PMListScreen
  refreshable
  xml_layout :embedded_listview
  title "View with a ListView Inside"

  def on_load
    find(:text_view).on(:tap) do
      d_opts = {
        w: rmq.device.width * 0.8,
        h: rmq.device.height * 0.8,
        xml_layout: app.r.layout(:dialog_list_view),
      }
      dialog = PotionDialog.new(d_opts).dialog

      # TODO: would be nice if this were wrapped
      @listview = dialog.findViewById(R::Id::Dialog_list_view) # can't use RMQ here yet
      simple_data_adapter = PMBaseAdapter.new(data: buncho_cells)
      @listview.adapter = simple_data_adapter
      find(@listview).on(:tap) do |parent, view, position, _id|
        # have fun with those click events
        find(view).style { |st| st.background_color = rmq.color.random }
      end
    end
  end

  def table_data
    [{
      cells: buncho_cells
    }]
  end

  def on_refresh
    mp "I was refreshed!"
    update_table_data
    stop_refreshing
  end

  private

  def buncho_cells
    array_of_cells = []
    100.times do |i|
      array_of_cells << {title: "Here's cell #{i}"}
    end
    array_of_cells
  end

end
