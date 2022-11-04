import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/provider/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatelessWidget {
  final String id;

  const ReviewDialog({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController reviewController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ReviewProvider(apiService: ApiService()),
      child: Consumer<ReviewProvider>(
        builder: (context, state, _) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              'Review $id',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            content: Column(children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: reviewController,
                maxLines: 8,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Your Review Here'),
              ),
            ]),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  state.postReviewById(
                      id, nameController.text, reviewController.text);
                  final snackBar = SnackBar(
                    content: Text(state.message),
                  );
                  Navigator.pop(context, 'Add Review Success');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text('Send Review'),
              ),
            ],
          );
        },
      ),
    );
  }
}
