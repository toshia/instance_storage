# -*- coding: utf-8 -*-
require "instance_storage/version"

# クラスに、インスタンスの辞書をもたせる。
# このモジュールをincludeすると、全てのインスタンスは一意な名前(Symbol)をもつようになり、
# その名前を通してインスタンスを取得することができるようになる。
module InstanceStorage

  attr_reader :name

  alias to_sym name

  def self.included(klass)
    klass.extend InstanceStorageExtend
    klass.clear!
  end

  def initialize(name)
    @name = name end

  # 名前を文字列にして返す
  # ==== Return
  # 名前文字列
  def to_s
    @name.to_s end

  module InstanceStorageExtend
    # 定義されているインスタンスを全て削除する
    def clear!
      @instances = {}
      @storage_lock = Mutex.new end

    # インスタンス _event_name_ を返す。既に有る場合はそのインスタンス、ない場合は新しく作って返す。
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # Event
    def [](name)
      name_sym = name.to_sym
      if @instances.has_key?(name_sym)
        @instances[name_sym]
      else
        @storage_lock.synchronize{
          if @instances.has_key?(name_sym)
            @instances[name_sym]
          else
            @instances[name_sym] = self.new(name_sym) end } end end

    # このクラスのインスタンスを全て返す
    # ==== Return
    # インスタンスの配列(Array)
    def instances
      @instances.values end

    # このクラスのインスタンスの名前を全て返す
    # ==== Return
    # インスタンスの名前の配列(Array)
    def instances_name
      @instances.keys end

    # 名前 _name_ に対応するインスタンスが存在するか否かを返す
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # インスタンスが存在するなら真
    def instance_exist?(name)
      @instances.has_key? name.to_sym end

    # _name_ に対応するインスタンスが既にあれば真
    # ==== Args
    # [name] インスタンスの名前(Symbol)
    # ==== Return
    # インスタンスかnil
    def instance(name)
      @instances[name.to_sym] end

    def destroy(name)
      @instances.delete(name.to_sym) end
  end
end
