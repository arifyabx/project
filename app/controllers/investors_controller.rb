class InvestorsController < ApplicationController
  def new
    # create new investor profile
  end

  def index
    # show all the investor's existing investment
    # InvestorInvestment.where(investor_id: @investor.id)
  end

  def edit
    # edit investor
  end

  def destroy
    # delete investor
  end

  def show_all_txns
    # Transaction.where(relates_to_type: 'Investment').distinct(:relates_to_id).order(id: :desc)
  end

  def show
    case params[:id].to_i
      when 1
        data = File.read('data/simple_ledger.json')
      when 2
        data = File.read('data/duplicate_ledger.json')
      when 3
        data = File.read('data/complicated_ledger.json')
      else
        data = File.read('data/simple_ledger.json')
    end
    response = JSON.parse(data)
    sorted_ledger_records = response.sort_by { |transaction| transaction["date"] }
    activity_ids = []
    @validated_ledger_records = []
    @account_balance = 0.0
    sorted_ledger_records.reverse.each do |record|
      if activity_ids.include?(record["activity_id"])
        next
      elsif %w[DEPOSIT REFUND].include?(record["type"])
        @account_balance += record["amount"]
        description = "Requested amount deposited/refunded from #{record["source"]["description"]} to #{record["destination"]["description"]}"
        @validated_ledger_records << {transaction_date: record["date"].to_date.strftime("%m/%d/%y"),
                                     transaction_type: record["type"],
                                     description: description,
                                     amount: record["amount"],
                                     balance: record["balance"]}
        activity_ids << record["activity_id"]
      elsif %w[WITHDRAWAL TRANSFER].include?(record["type"])
        if record["amount"] > @account_balance
          flash[:notice] = "Balance isn't enough for process the withdrawl/transfer request"
        else
          @account_balance += record["amount"]
          description = "Requested amount withdrawl/transfered from #{record["source"]["description"]} to #{record["destination"]["description"]}"
          @validated_ledger_records << {transaction_date: record["date"].to_date.strftime("%m/%d/%y"),
                                     transaction_type: record["type"],
                                     description: description,
                                     amount: record["amount"],
                                     balance: record["balance"]}
        end
        activity_ids << record["activity_id"]
      elsif record["type"] = "INVESTMENT"
        description = "#{record["source"]["description"]} invested into #{record["destination"]["description"]}"
        @validated_ledger_records << {transaction_date: record["date"].to_date.strftime("%m/%d/%y"),
                                     transaction_type: record["type"],
                                     description: description,
                                     amount: record["amount"],
                                     balance: record["balance"]}
        @account_balance += record["amount"]
        activity_ids << record["activity_id"]
      end
    end
  end
end
