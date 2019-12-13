require_relative '../lib/champions.rb'
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :champions_url, :all_champs
  BASE_PATH = 'https://leagueoflegends.fandom.com'
  def initialize
    @champions_url = []
    @all_champs = { name: [], title: [], role: [] }
  end

  def getChamps
    site = Nokogiri::HTML(open(BASE_PATH + '/wiki/List_of_champions'))
    site.css('table.wikitable.sortable').each do |champ|
      champ.css('tr td:first').each_with_index do |names, _index|
        @all_champs[:name] << names.attribute('data-sort-value').value
      end
      champ.css('tr td[2] span').each.with_index(0) do |types, _index|
        @all_champs[:role] << types.attribute('data-param').text
      end
      champ.css('tr td:first span:first:first a:first:first').each do |url|
        @champions_url << url.attribute('href').text
      end
      champ.css('tr td:first span:first:first a:first:last').each do |url|
        @all_champs[:title] << url.text
        @all_champs[:title].delete('')
      end
    end
    create_champions
  end

  def create_champions
    temp = ''
    index = 0
    while index < @all_champs[:name].size
      temp = @all_champs[:name][index]
      Champion.new(temp, @all_champs[:title][index], @all_champs[:role][index])
      index += 1
    end
  end

  def getChampAbilities(name)
    abilities = []
    puts name

    name = '/wiki/' << if name.include?("'")
                         name.gsub("'", '%27')
                       elsif name.include?(' ')
                         name.gsub(' ', '_')
                       elsif name.include?('.')
                         name.gsub('.', '._')
                       else
                         name
                       end

    if @champions_url.uniq.include?(name)
      champ_site = Nokogiri::HTML(open(BASE_PATH + "#{name}/Abilities"))
      puts champ_site.title
      binding.pry
      champ_site.css('.skill .ability-info-container').each.with_index(0) do |ability, _index|
        abilities << ability.css('tr[1] td:nth-child(1)').text.gsub(/\R+/, "|| \n") + ability.css('tr td p').text
      end
       # abilities << 
      append_keys(abilities)
    else
      puts 'Champion not found!'
    end
  end

  def append_keys(array)
    array[0].prepend('|         ||')
    array[1].prepend('|    Q:   ||')
    array[2].prepend('|    W:   ||')
    array[3].prepend('|    E:   ||')
    array[4].prepend('|    R:   ||')
    array
  end
end
