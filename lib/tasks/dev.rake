namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    #só no modo de desenvolvimento
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins) 
      
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end
  
  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do 
      
      coins = [ { description: "Bitcoin", 
                  acronym: "BTC", 
                  url_image: "https://imagepng.org/wp-content/uploads/2017/06/moeda-bitcoin-coin.png",
                  mining_type: MiningType.find_by(acronym: 'PoW')
                },
                { description: "Ethereum", 
                  acronym: "ETH", 
                  url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png",
                  mining_type: MiningType.all.sample
                },
                { description: "Dash", 
                  acronym: "DASH", 
                  url_image: "https://cdn.freebiesupply.com/logos/large/2x/dash-3-logo-png-transparent.png",
                  mining_type: MiningType.all.sample
                },
                { description: "Iota", 
                  acronym: "IOT", 
                  url_image: "https://icon2.kisspng.com/20180712/faa/kisspng-iota-cryptocurrency-logo-internet-of-things-tether-aren-5b481f06876cc2.5540898915314531905547.jpg",
                  mining_type: MiningType.all.sample
                },
                { description: "ZCash", 
                  acronym: "ZEC", 
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1437.png",
                  mining_type: MiningType.all.sample
                }]
      
      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do 
      
      mining_types = [{description:"Proof of Work", acronym: "PoW"},
                      {description:"Proof of Stake", acronym:"PoS"},
                      {description:"Proof of Capacity", acronym:"PoC"}]
      mining_types.each do |type|
        MiningType.find_or_create_by!(type)
      end
    end
  end

  #Só esse módulo consegue executar o que vem embaixo
  private
  
  def show_spinner(msg_start, msg_end = "Concluído!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin # Automatic animation with default interval
      yield
      spinner.success("(#{msg_end})")
    end

end
