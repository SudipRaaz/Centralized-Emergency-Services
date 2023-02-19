import 'package:ems_project/resource/constants/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ShowDialog {
  void changeMyPassowrd(BuildContext context, Function onPress) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                addVerticalSpace(15),
                const Text(
                    'Please check you registered Mail box for a Password reset Email '),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                onPress;
              },
            ),
          ],
        );
      },
    );
  }

  void reportBug(BuildContext context, Function onPress) async {
    TextEditingController reportBug = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Report Bug'),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                addVerticalSpace(15),
                const Text('Please Describe your issue'),
                addVerticalSpace(15),
                TextField(
                  controller: reportBug,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
                onPress;
              },
            ),
          ],
        );
      },
    );
  }

  void showFeedbackForm(BuildContext context, Function onPress) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return RatingDialog(
          initialRating: 1.0,
          // your app's name?
          title: const Text(
            'Experience Rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          // encourage your user to leave a high rating?
          message: const Text(
            'Tap a star to set your rating. \n And Leave us a comment.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          // your app's logo?
          image: const FlutterLogo(size: 100),
          submitButtonText: 'Submit',
          commentHint: 'Leave a comment (Optional)',
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) {
            print('rating: ${response.rating}, comment: ${response.comment}');

            // TODO: add your own logic
            if (response.rating < 3.0) {
              // send their comments to your email or anywhere you wish
              // ask the user to contact you instead of leaving a bad review
            } else {
              // _rateAndReviewApp();
            }
          },
        );
      },
    );
  }
}
