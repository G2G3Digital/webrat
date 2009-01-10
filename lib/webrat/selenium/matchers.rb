module Webrat
  module Selenium
    module Matchers

      class HaveXpath
        def initialize(expected)
          @expected = expected
        end
        
        def matches?(response)
          response.session.wait_for do
            response.selenium.is_element_present("xpath=#{@expected}")
          end
        end

        # ==== Returns
        # String:: The failure message.
        def failure_message
          "expected following text to match xpath #{@expected}:\n#{@document}"
        end

        # ==== Returns
        # String:: The failure message to be displayed in negative matches.
        def negative_failure_message
          "expected following text to not match xpath #{@expected}:\n#{@document}"
        end
      end
      
      def have_xpath(xpath)
        HaveXpath.new(xpath)
      end
      
      class HaveSelector
        def initialize(expected)
          @expected = expected
        end
        
        def matches?(response)
          response.session.wait_for do
            response.selenium.is_element_present("css=#{@expected}")
          end
        end

        # ==== Returns
        # String:: The failure message.
        def failure_message
          "expected following text to match selector #{@expected}:\n#{@document}"
        end

        # ==== Returns
        # String:: The failure message to be displayed in negative matches.
        def negative_failure_message
          "expected following text to not match selector #{@expected}:\n#{@document}"
        end
      end
      
      def have_selector(content)
        HaveSelector.new(content)
      end
      
      class HasContent #:nodoc:
        def matches?(response)
          if @content.is_a?(Regexp)
            text_finder = "regexp:#{@content.source}"
          else
            text_finder = @content
          end
          
          response.session.wait_for do
            response.selenium.is_text_present(text_finder)
          end
        end
      end
      
    end
  end
end