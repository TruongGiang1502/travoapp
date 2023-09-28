import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/utils/list_favor.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favor Screen'),
      ),
      body: ListView.builder(
        itemCount: desFavor.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 1)
                  )
                ]
              ),
              padding: const EdgeInsetsDirectional.all(16),
              width: size.width*0.75,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(desFavor[index].imageUrl),
                    )
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Text(desNameFavor[index].$1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(desFavor[index].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 16,),
                            Text(desFavor[index].rating, style: const TextStyle(fontSize: 16),),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
      );
    }
    
}