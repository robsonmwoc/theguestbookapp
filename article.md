# DCI and Rails - Will it blend?

Hi there, if you're here, it's because you've got interested by DCI, and want to know what it is. So, let's start talking about its meaning, and then, we can move to its combination with Rails. 

## What is DCI

`DCI` stands for `Data`, `Context` and `Interaction`, it's a different way to deal with the many concerns of an application. It was created by Trygve Reenskaug, also creator of MVC, that faced some flexibilities problems with his pattern, mainly for larger applications. So does Rails when things get big enough.

The main appeal of DCI, is that most of programmer has been doing Class Oriented Programming, instead of Object Oriented Programming. The reason for that, is that we're too used to design our code in classes, instead on concentrate our thoughts in generate results through object interactions.

Going further on the aspects of DCI, Data represents what your application `IS`. The Interaction between objects represents what the application `DOES`, and finally Context is the place, where Data objects assume Roles to interact to each other and generate business value.

## Coding time!

This is better represented with a piece of code. Let's take a look on a bank account manager app, more specifically, implementing money transferring between two accounts.

The Data will be represented for this Account model:

    class Account < ActiveRecord::Base
      def drecrease_balance(amount); end
      def increase_balance(amount); end
      def balance; end
      def update_log(message, amount); end
    end

The Context is the class responsible to manage the interaction between the objects, so:

    class TransferringMoneyContext
      attr_reader :source_account, :destination_account
      def initialize(source_account, destination_account)
        @source_account = source_account.extend SourceAccount
        @destination_account = destination_account.extend DestinationAccount
      end

      def execute
        @source_account.transfer_out amount
        @destination_account.transfer_in amount
      end 
      ...
    end

Now we gonna need the `Roles`. A `Role` for DCI is a set of functionalities that only make sense for that Context. This way, the Data objects can receive new behaviors in runtime to accomplish with their objectives in generating business value. This makes clear that ActiveRecord models, will never have any business logic inside of them, it's all concentrated into Contexts and Roles, totally decoupled from Rails.

    class TransferringMoneyContext
      ...
      module SourceAccount
        def transfer_out(amount)
          raise "Insufficient funds" if balance < amount
          decrease_balance amount
          context.destination_account.transfer_in amount
          update_log "Transferred out", amount
        end
      end

      module DestinationAccount
        def transfer_in(amount)
          increase_balance amount
          update_log "Transferred in", amount
        end
      end
    end

The way you add these Roles to an object is using the `extend` method:

    source_account.extend SourceAccount

With this call, the model now obtained the method `transfer_out`.

## Now let's talk about its combination with Rails!

It's a common sense that Rails has a strong opinion about how your application should be written. It is hardly bind to a misleading MVC structure, and standardize a set of conventions that usually screams out how your application will be organized and developed.

Despite these problems, in my opinion, Rails continues to be the best choice for development of websites and REST APIs. It's way easier using it.

After many years working with this framework, I started to tryout new approaches to decouple my business from the framework. Initially I tried use Concerns, but it was a messy thing to do, hard to organize. With DCI I've found a better sit.

We can take advantage of the regular Rails conventions, such as autoload, the `app` folder, so now the Rails app looks like this:

    app
      contexts
        transfering_money_context.rb
      controllers
        application_controller.rb
        accounts_controller.rb
      models
        account.rb
      roles
        source_account.rb
        destination_account.rb
      views

# Some advantages of DCI

Now that you have Roles and Contexts combined with your project, testing will probably be easier to do, because hosting business logic inside controllers is not a pleasant thing.

The controller tests will be limited to validate small aspects of communication with the clients, and models tests will be resumed to validation and little queries.

The great amount of work will be played by Contexts and Roles combined, and this makes your application easier to get upgrades from Rails.

# Some disadvantages of DCI

The way most people think about DCI is that it resumes to `extend` objects in runtime, and this is slow. But, another approach that is way more reliable is using delegation (kinda Decorator Pattern), where you wrap your data object with a Role class, and deals with the missing methods gracefully.

# More subjects related

DCI guide me to find another interesting topics such as Hexagon Architectures, and Components-Based Architectures that's one of my favorite approach to development with Rails.

In a next opportunity we can talk about them as well.

Cheers, see ya!