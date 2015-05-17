class RMQ
    def data(new_data = :rmq_not_provided)
      if new_data != :rmq_not_provided
        selected.each do |view|
          case view
          #when UILabel              then view.setText new_data # set is faster than =
          #when UIButton             then view.setTitle(new_data, forState: UIControlStateNormal)
          #when UIImageView          then view.image = new_data
          #when UITableView          then
          #when UISwitch             then view.setOn(new_data)
          #when UIDatePicker         then
          #when UISegmentedControl   then
          #when UIRefreshControl     then
          #when UIPageControl        then
          #when UISlider             then
          #when UIStepper            then
          #when UITabBar             then
          #when UITableViewCell      then
          when Potion::TextView      then view.text = new_data
          #when UITextField          then view.text = new_data
          #when UINavigationBar      then
          #when UIScrollView         then
          #when UIProgressView       then view.setProgress(new_data, animated: true)

          # TODO, finish
          end
        end

        self
      else
        out = selected.map do |view|
          case view
          #when UILabel              then view.text
          #when UIButton             then view.titleForState(UIControlStateNormal)
          #when UIImageView          then view.image
          #when UITableView          then
          #when UISwitch             then
          #when UIDatePicker         then
          #when UISegmentedControl   then
          #when UIRefreshControl     then
          #when UIPageControl        then
          #when UISlider             then
          #when UIStepper            then
          #when UITabBar             then
          #when UITableViewCell      then
          when Potion::TextView      then view.text
          #when UITextField          then view.text
          #when UINavigationBar      then
          #when UIScrollView         then
          #when UIProgressView       then view.progress

          # TODO, finish
          end
        end

        out = out.first if out.length == 1
        out
      end
    end

    def data=(new_data)
      self.data(new_data)
    end
end
