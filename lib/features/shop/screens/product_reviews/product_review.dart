import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatefulWidget {
  final String? productName;
  final double? rating;
  final int? reviewCount;

  const ProductReviewScreen({
    super.key,
    this.productName,
    this.rating,
    this.reviewCount,
  });

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  String selectedFilter = 'All';
  final List<String> filterOptions = ['All', '5 Stars', '4 Stars', '3 Stars', '2 Stars', '1 Star'];

  // Mock review data
  final List<Map<String, dynamic>> reviews = [
    {
      'rating': 5,
      'userName': 'John D.',
      'comment': 'Excellent quality! Very comfortable and stylish. I\'ve been wearing these for weeks and they still look brand new. Highly recommend!',
      'date': '2 days ago',
      'verified': true,
      'helpful': 12,
      'storeResponse': {
        'comment': 'Thank you so much for your wonderful review, John! We\'re thrilled that you\'re loving your new shoes. Your satisfaction is our top priority!',
        'date': '1 day ago',
        'responderName': 'Customer Care Team'
      }
    },
    {
      'rating': 4,
      'userName': 'Sarah M.',
      'comment': 'Good shoes but sizing runs a bit small. I had to exchange for a half size up. Otherwise, great quality and fast shipping.',
      'date': '1 week ago',
      'verified': true,
      'helpful': 8,
      'storeResponse': {
        'comment': 'Hi Sarah! Thanks for the feedback about sizing. We\'ve updated our size guide to help future customers. We\'re glad the exchange process was smooth and you\'re happy with the quality!',
        'date': '6 days ago',
        'responderName': 'Customer Care Team'
      }
    },
    {
      'rating': 5,
      'userName': 'Mike R.',
      'comment': 'Love these! Perfect for my morning runs. Great cushioning and support. Worth every penny.',
      'date': '2 weeks ago',
      'verified': false,
      'helpful': 15,
    },
    {
      'rating': 3,
      'userName': 'Lisa K.',
      'comment': 'Decent quality for the price. The color is nice but the material feels a bit cheap. They\'re okay for casual wear.',
      'date': '3 weeks ago',
      'verified': true,
      'helpful': 3,
      'storeResponse': {
        'comment': 'Hello Lisa, thank you for your honest feedback. We appreciate all reviews as they help us improve. We\'d love to learn more about your experience - please reach out to our support team if you\'d like to discuss further.',
        'date': '3 weeks ago',
        'responderName': 'Customer Care Team'
      }
    },
    {
      'rating': 4,
      'userName': 'Tom W.',
      'comment': 'Great customer service and fast delivery. The shoes are comfortable and look exactly like the photos. Very satisfied with my purchase.',
      'date': '1 month ago',
      'verified': true,
      'helpful': 6,
    },
    {
      'rating': 5,
      'userName': 'Emma L.',
      'comment': 'Amazing shoes! I get compliments everywhere I go. Super comfortable for long walks and they go with everything.',
      'date': '1 month ago',
      'verified': true,
      'helpful': 20,
    },
    {
      'rating': 2,
      'userName': 'David P.',
      'comment': 'Not what I expected. The quality doesn\'t match the price. Had issues with the sole after just a few weeks of wear.',
      'date': '2 months ago',
      'verified': true,
      'helpful': 4,
      'storeResponse': {
        'comment': 'Hi David, we\'re sorry to hear about your experience. This doesn\'t meet our quality standards. Please contact our support team with your order details so we can make this right for you.',
        'date': '2 months ago',
        'responderName': 'Customer Care Team'
      }
    },
    {
      'rating': 4,
      'userName': 'Rachel S.',
      'comment': 'Good value for money. Comfortable fit and nice design. My only complaint is that they attract dirt easily.',
      'date': '2 months ago',
      'verified': false,
      'helpful': 7,
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    if (selectedFilter == 'All') return reviews;
    
    int targetRating = int.parse(selectedFilter.split(' ')[0]);
    return reviews.where((review) => review['rating'] == targetRating).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final productName = widget.productName ?? 'Product';
    final rating = widget.rating ?? 4.5;
    final reviewCount = widget.reviewCount ?? reviews.length;

    return Scaffold(
      // Your custom AppBar
      appBar: TAppBar(
        title: const Text('Reviews & Ratings'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      
      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Reviews Summary Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              decoration: BoxDecoration(
                color: dark ? TColors.dark : TColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Overall Rating
                  Row(
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TColors.primary,
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < rating.floor()
                                      ? Icons.star
                                      : index < rating
                                          ? Icons.star_half
                                          : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              }),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Based on $reviewCount reviews',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _showWriteReviewDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(TSizes.sm),
                          ),
                        ),
                        child: const Text(
                          'Write Review',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // Rating Breakdown
                  _buildRatingBreakdown(context),
                ],
              ),
            ),

            // Filter Options
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                itemCount: filterOptions.length,
                itemBuilder: (context, index) {
                  final option = filterOptions[index];
                  final isSelected = selectedFilter == option;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: TSizes.xs),
                    child: FilterChip(
                      label: Text(option),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = option;
                        });
                      },
                      backgroundColor: dark ? TColors.darkGrey : TColors.light,
                      selectedColor: TColors.primary.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? TColors.primary : null,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? TColors.primary : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Reviews List
            filteredReviews.isEmpty
                ? _buildEmptyState(context)
                : Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: filteredReviews.map((review) {
                        final index = filteredReviews.indexOf(review);
                        return Column(
                          children: [
                            _ReviewCard(
                              rating: review['rating'],
                              userName: review['userName'],
                              comment: review['comment'],
                              date: review['date'],
                              isVerified: review['verified'],
                              helpfulCount: review['helpful'],
                              storeResponse: review['storeResponse'],
                              onHelpful: () => _markHelpful(reviews.indexOf(review)),
                            ),
                            if (index < filteredReviews.length - 1)
                              const Divider(height: 32),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Rating Breakdown Widget
  Widget _buildRatingBreakdown(BuildContext context) {
    final ratingCounts = {5: 45, 4: 25, 3: 8, 2: 3, 1: 2};
    final total = ratingCounts.values.reduce((a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating Breakdown',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        ...ratingCounts.entries.map((entry) {
          final stars = entry.key;
          final count = entry.value;
          final percentage = count / total;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text('$stars'),
                const SizedBox(width: 4),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: TSizes.xs),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(width: TSizes.xs),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // Empty State Widget
  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'No reviews found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.xs),
            Text(
              'No reviews match your current filter',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilter = 'All';
                });
              },
              child: const Text('Show All Reviews'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Functions
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Reviews'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search in reviews...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Search feature coming soon!');
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showWriteReviewDialog(BuildContext context) {
    int selectedRating = 0;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Rate this product:'),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setDialogState(() {
                        selectedRating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < selectedRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                  );
                }),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your thoughts about this product...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedRating > 0 ? () {
                Navigator.pop(context);
                _showSnackBar(context, 'Review submitted! Thank you! 🙏');
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markHelpful(int index) {
    setState(() {
      reviews[index]['helpful']++;
    });
    _showSnackBar(context, 'Thanks for your feedback! 👍');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.sm),
        ),
      ),
    );
  }
}

// Review Card Widget
class _ReviewCard extends StatelessWidget {
  final int rating;
  final String userName;
  final String comment;
  final String date;
  final bool isVerified;
  final int helpfulCount;
  final Map<String, dynamic>? storeResponse;
  final VoidCallback onHelpful;

  const _ReviewCard({
    required this.rating,
    required this.userName,
    required this.comment,
    required this.date,
    required this.isVerified,
    required this.helpfulCount,
    this.storeResponse,
    required this.onHelpful,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: BorderRadius.circular(TSizes.md),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: TColors.primary.withOpacity(0.1),
                child: Text(
                  userName[0],
                  style: TextStyle(
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: TSizes.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Verified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: TSizes.xs),
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, size: 20),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Report Review'),
                    onTap: () => _showSnackBar(context, 'Review reported'),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems),
          
          // Review Comment
          Text(
            comment,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems),
          
          // Helpful Section
          Row(
            children: [
              Text(
                'Was this helpful?',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: TSizes.sm),
              GestureDetector(
                onTap: onHelpful,
                child: Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_outlined,
                      size: 16,
                      color: TColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Yes ($helpfulCount)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: TSizes.sm),
              GestureDetector(
                onTap: () => _showSnackBar(context, 'Thanks for your feedback!'),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_down_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'No',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Store Response Section
          if (storeResponse != null) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: TSizes.lg),
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(TSizes.sm),
                border: Border.all(
                  color: TColors.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.store,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: TSizes.xs),
                      Text(
                        storeResponse!['responderName'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: TColors.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        storeResponse!['date'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.xs),
                  Text(
                    storeResponse!['comment'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.sm),
        ),
      ),
    );
  }
}