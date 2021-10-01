# frozen_string_literal: true

# Clase para los observados
class Observable
  attr_accessor :is_called_notify_all

  def initialize
    @observers = []
    @is_called_notify_all = 0 # Se crea con motivos de testing
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_all
    @observers.each { |observer| observer.update(self) }
    @is_called_notify_all = 1 # Se ha llamado a la función
  end
end
