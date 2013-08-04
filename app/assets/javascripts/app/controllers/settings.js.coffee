class System extends App.ControllerTabs
  constructor: ->
    super

    return if !@authenticate()

    @tabs = [
      { name: 'Base',     'target': 'base',      controller: App.SettingsArea, params: { area: 'System::Base' } },
  #    { name: 'Language', 'target': 'language',  controller: App.SettingsSystem, params: { area: 'System::Language' } },
  #    { name: 'Log',      'target': 'log',       controller: App.SettingsSystem, params: { area: 'System::Log' } },
      { name: 'Storage',  'target': 'storage',   controller: App.SettingsArea, params: { area: 'System::Storage' } },
    ]

    # render page
    @render()

class Security extends App.ControllerTabs
  constructor: ->
    super

    return if !@authenticate()

    @tabs = [
      { name: 'Base',                     'target': 'base',             controller: App.SettingsArea, params: { area: 'Security::Base' } },
#       { name: 'Authentication',           'target': 'auth',             controller: App.SettingsArea, params: { area: 'Security::Authentication' } },
      { name: 'Password',                 'target': 'password',         controller: App.SettingsArea, params: { area: 'Security::Password' } },
      { name: 'Third-Party Applications', 'target': 'third_party_auth', controller: App.SettingsArea, params: { area: 'Security::ThirdPartyAuthentication' } },
#       { name: 'Session',        'target': 'session',   controller: '' },
    ]

    @render()

class Import extends App.ControllerTabs
  constructor: ->
    super

    return if !@authenticate()

    # import
    @tabs = [
      { name: 'Base',           'target': 'base',          controller: App.SettingsArea, params: { area: 'Import::Base' } },
      { name: 'OTRS',           'target': 'otrs',          controller: App.SettingsArea, params: { area: 'Import::OTRS' } },
    ]

    @render()

class Ticket extends App.ControllerTabs
  constructor: ->
    super

    return if !@authenticate()

    # ticket
    @tabs = [
      { name: 'Base',           'target': 'base',          controller: App.SettingsArea, params: { area: 'Ticket::Base' } },
      { name: 'Number',         'target': 'number',        controller: App.SettingsArea, params: { area: 'Ticket::Number' } },
#      { name: 'Sender Format',  'target': 'sender-format', controller: App.SettingsArea, params: { area: 'Ticket::SenderFormat' } },
    ]

    @render()

App.Config.set( 'SettingSystem', { prio: 1400, parent: '#settings', name: 'System', target: '#settings/system', controller: System, role: ['Admin'] }, 'NavBarLevel44' )
App.Config.set( 'SettingSecurity', { prio: 1500, parent: '#settings', name: 'Security', target: '#settings/security', controller: Security, role: ['Admin'] }, 'NavBarLevel44' )
App.Config.set( 'SettingImport', { prio: 1550, parent: '#settings', name: 'Import', target: '#settings/import', controller: Import, role: ['Admin'] }, 'NavBarLevel44' )
App.Config.set( 'SettingTicket', { prio: 1600, parent: '#settings', name: 'Ticket', target: '#settings/ticket', controller: Ticket, role: ['Admin'] }, 'NavBarLevel44' )

