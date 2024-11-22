class TransactionModel{

  int? id;
  String? type;
  int? amount;
  String? description;
  String? status;
  String? reference;
  String? batchNo;
  String? transactionType;
  String? visibility;
  String? createdAt;

  TransactionModel(this.id,this.type,this.amount,
      this.description,this.status,this.reference,this.batchNo,
      this.transactionType,this.visibility,this.createdAt);

  TransactionModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    reference = json['reference'];
    batchNo = json['batch_no'];
    transactionType = json['transaction_type'];
    visibility = json['visibility'];
  }
}