# -*- coding: utf-8 -*-
require "instance_storage/version"

# クラスに、インスタンスの辞書をもたせる。
# このモジュールをincludeすると、全てのインスタンスは一意な名前(Symbol)をもつようになり、
# その名前を通してインスタンスを取得することができるようになる。
module InstanceStorage

  attr_reader :name

  alias to_sym name

  def self.included(klass)
    super
    klass.class_eval do
      extend InstanceStorageExtend
    end
  end

  def initialize(name)
    @name = name.to_sym end

  # 名前を文字列にして返す
  # ==== Return
  # 名前文字列
  def to_s
    @name.to_s end

  module InstanceStorageExtend
    def instances_dict
      @instances ||= {} end

    def storage_lock
      @storage_lock ||= Mutex.new end

    # 定義されているインスタンスを全て削除する
    def clear!
      @instances = nil
      self
    end

    # インスタンス _event_name_ を返す。既に有る場合はそのインスタンス、ない場合は新しく作って返す。
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # Event
    def [](name)
      name_sym = name.to_sym
      if instances_dict.has_key?(name_sym)
        instances_dict[name_sym]
      else
        storage_lock.synchronize{
          if instances_dict.has_key?(name_sym)
            instances_dict[name_sym]
          else
            instances_dict[name_sym] = self.new(name_sym) end } end end

    # このクラスのインスタンスを全て返す
    # ==== Return
    # インスタンスの配列(Array)
    def instances
      instances_dict.values end

    # このクラスのインスタンスの名前を全て返す
    # ==== Return
    # インスタンスの名前の配列(Array)
    def instances_name
      instances_dict.keys end

    # 名前 _name_ に対応するインスタンスが存在するか否かを返す
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # インスタンスが存在するなら真
    def instance_exist?(name)
      instances_dict.has_key? name.to_sym end

    # _name_ に対応するインスタンスが既にあれば真
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # インスタンスかnil
    def instance(name)
      instances_dict[name.to_sym] end

    def destroy(name)
      instances_dict.delete(name.to_sym)
      self
    end
  end
end
