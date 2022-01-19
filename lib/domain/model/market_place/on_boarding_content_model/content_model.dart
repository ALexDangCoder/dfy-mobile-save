import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

class OnBoardingContent {
  final String image;
  final String title;
  final String descriptionNormal;
  final String descriptionYellow;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.descriptionNormal,
    required this.descriptionYellow,
  });
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    title: '${S.current.step} 1',
    image: ImageAssets.content1,
    descriptionNormal: S.current.create_an_unauth_hard_nft,
    descriptionYellow: 'hard NFT',
  ),
  OnBoardingContent(
    title: '${S.current.step} 2',
    image: ImageAssets.content2,
    descriptionNormal: S.current.send_evalue_to_evaluator,
    descriptionYellow: S.current.to_evaluator,
  ),
  OnBoardingContent(
    title: '${S.current.step} 3',
    image: ImageAssets.content3,
    descriptionNormal: S.current.receive_accept_result_blockchain,
    descriptionYellow: S.current.on_blockchain,
  ),
  OnBoardingContent(
    title: '${S.current.step} 4',
    image: ImageAssets.content4,
    descriptionNormal:
        '${S.current.put_hard_nft_market} ${S.current.marketplace}',
    descriptionYellow: S.current.to_take_profit,
  ),
];
