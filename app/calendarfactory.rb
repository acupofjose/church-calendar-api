module ChurchCalendar

  # creates Calendar instances with the same Sanctorale
  class CalendarFactory

    # Expects a list of paths to Sanctorale data files.
    # All will be loaded in the given order, eventually overwritting
    # entries of each other, the last one having the last word.
    # The resulting Sanctorale will be provided to all Calendars
    # created here.
    def initialize(*sanctorales)
      loader = CalendariumRomanum::SanctoraleLoader.new
      @sanctorale = CalendariumRomanum::Sanctorale.new

      # load sanctorale definitions over each other
      sanctorales.each do |path|
        s = CalendariumRomanum::Sanctorale.new
        loader.load_from_file s, path
        @sanctorale.update s
      end
    end

    def for_year(year)
      c = CalendariumRomanum::Calendar.new year
      update c
      return c
    end

    def for_day(date)
      c = CalendariumRomanum::Calendar.for_day date
      update c
      return c
    end

    private

    # make the Calendar conform to expected setup
    def update(cal)
      cal.sanctorale = @sanctorale
    end
  end
end
