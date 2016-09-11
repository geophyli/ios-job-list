class HomeScreen < PM::TableScreen
  title "职位列表"
  stylesheet HomeScreenStylesheet

  include NavigationHelper

  def on_load
    add_side_menu

    @jobs = []
    load_jobs
  end

  def sign_out_button
    Auth.sign_out do
      app.delegate.open_authenticated_root
    end
  end

  def sign_in_button
    open SignInScreen.new(nav_bar: true)
  end

  def load_jobs
    Job.all do |response, jobs|
      if response.success?
        @jobs = jobs
        stop_refreshing
        update_table_data
      else
        app.alert 'Sorry,there was an error fetching the jobs.'
        mp response.error.localizedDesription
      end
    end
  end

  def table_data
    [{
      cells: @jobs.map do |job|
        {
          height: 100,
          title: job.title,
          subtitle: job.content,
          action: :view_job,
          arguments: { job: job }
        }
      end
    }]
  end

  def view_job(args)
    open JobScreen.new(args)
  end

  def nav_left_button
    mp 'Left button'
  end

  def nav_right_button
    mp 'Right button'
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
    find.all.reapply_styles
  end
end
