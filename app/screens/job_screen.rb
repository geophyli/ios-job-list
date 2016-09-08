class JobScreen < PM::Screen
  stylesheet JobScreenStylesheet

  attr_accessor :job

  def on_load
    self.title = @job.title

    @content = append!(UILabel, :job_content)
    @content.text = @job.content

    @image = append!(UIImageView, :job_image).style { |st| st.remote_image = @job.image_url }
  end



  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
