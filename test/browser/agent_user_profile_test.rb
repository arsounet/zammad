# encoding: utf-8
require 'browser_test_helper'

class AgentUserProfileTest < TestCase
  def test_user_profile
    message = '1 ' + rand(99999999).to_s

    @browser = browser_instance
    login(
      :username => 'master@example.com',
      :password => 'test',
      :url      => browser_url,
    )
    tasks_close_all()

    # search and open user
    user_open_by_search( :value => 'Braun' )

    watch_for(
      :css   => '.active .profile-window',
      :value => 'note',
    )
    watch_for(
      :css   => '.active .profile-window',
      :value => 'email',
    )

    # update note
    set(
      :css             => '.active [data-name="note"]',
      :value           => 'some note 123',
      :contenteditable => true,

    )
    click( :css => '#global-search' )
    sleep 2

    # check and change note again in edit screen
    click( :css => '.active .js-action .select-arrow' )
    click( :css => '.active .js-action a[data-type="edit"]' )

    watch_for(
      :css   => '.active .modal',
      :value => 'note',
    )
    watch_for(
      :css   => '.active .modal',
      :value => 'some note 123',
    )

    set(
      :css   => '.modal [data-name="note"]',
      :value => 'some note abc',
    )
    click( :css => '.active .modal button.js-submit' )

    watch_for(
      :css   => '.active .profile-window',
      :value => 'some note abc',
    )

    # create new ticket
    ticket_create(
      :data    => {
        :customer => 'nico',
        :group    => 'Users',
        :title    => 'user profile check ' + message,
        :body     => 'user profile check ' + message,
      },
    )

    # switch to org tab, verify if ticket is shown
    user_open_by_search( :value => 'Braun' )
    watch_for(
      :css   => '.active .profile-window',
      :value => 'user profile check ' + message,
    )
    tasks_close_all()



    # work with two browser windows
    message = 'comment 1 ' + rand(99999999999999999).to_s

    # use current session
    browser1 = @browser

    browser2 = browser_instance
    login(
      :browser  => browser2,
      :username => 'agent1@example.com',
      :password => 'test',
      :url      => browser_url,
    )
    tasks_close_all(
      :browser => browser2,
    )

    user_open_by_search(
      :browser => browser1,
      :value   => 'Braun',
    )
    user_open_by_search(
      :browser => browser2,
      :value   => 'Braun',
    )

    # update note
    set(
      :browser         => browser1,
      :css             => '.active [data-name="note"]',
      :value           => message,
      :contenteditable => true,
    )
    click(
      :browser => browser1,
      :css     => '#global-search',
    )

    watch_for(
      :browser => browser2,
      :css     => '.active .profile-window',
      :value   => message,
    )

  end
end