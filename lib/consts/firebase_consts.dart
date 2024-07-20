import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const usersCollection = "Users";
const productsCollection = "products";
const cartCollection = "cart";
const chatsCollection = "chats";
const messagesCollection = "messages";
