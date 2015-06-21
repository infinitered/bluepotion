class RMQ
    def data(new_data = :rmq_not_provided)
      if new_data != :rmq_not_provided
        selected.each do |view|
          case view
          when Potion::EditText      then view.text = new_data.to_s.toString
          when Potion::TextView      then view.text = new_data.to_s.toString
          # TODO, finish
          end
        end

        self
      else
        out = selected.map do |view|
          case view
          when Potion::EditText      then view.text.toString.to_s
          when Potion::TextView      then view.text
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
