import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:flutter/material.dart';

class ListMintRequest extends StatefulWidget {
  const ListMintRequest({
    Key? key,
    required this.listMintRequest,
    required this.cubit,
  }) : super(key: key);

  final List<MintRequestModel> listMintRequest;
  final HardNftMintRequestCubit cubit;

  @override
  _ListMintRequestState createState() => _ListMintRequestState();
}

class _ListMintRequestState extends State<ListMintRequest> {
  @override
  Widget build(BuildContext context) {
    if(widget.listMintRequest.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) {
        return Container();
      },);
    }
    else {
      return SizedBox();
    }
  }
}
