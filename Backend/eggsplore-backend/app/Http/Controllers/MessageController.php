<?php

namespace App\Http\Controllers;

use App\Models\Message;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MessageController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }

    private function getContacts()
    {
        $userId = Auth::id();

        return User::whereHas('sentMessages', function ($query) use ($userId) {
            $query->where('receiver_id', $userId);
        })->orWhereHas('receivedMessages', function ($query) use ($userId) {
            $query->where('sender_id', $userId);
        })->get();
    }

    private function searchUsers($search)
    {
        return User::where('name', 'like', $search.'%')
            ->orWhere('username', 'like', $search.'%')
            ->get();
    }

    public function inbox(Request $request)
    {
        $search = $request->input('search');

        $users = [];
        if ($search) {
            $users = $this->searchUsers($search);
        }

        $contacts = $this->getContacts();

        return response()->json([
            'contacts' => $contacts,
            'users' => $users,
            'search' => $search,
        ]);
    }

    public function index(Request $request, User $user)
    {
        $userId = Auth::id();

        $messages = Message::where(function ($query) use ($userId, $user) {
            $query->where('sender_id', $userId)->where('receiver_id', $user->id);
        })->orWhere(function ($query) use ($userId, $user) {
            $query->where('sender_id', $user->id)->where('receiver_id', $userId);
        })->orderBy('created_at', 'asc')->get();

        return response()->json([
            'messages' => $messages,
            'with_user' => $user,
        ]);
    }

    public function store(Request $request, User $user)
    {
        $request->validate([
            'message' => 'required|string|max:1000',
        ]);

        $message = Message::create([
            'sender_id' => Auth::id(),
            'receiver_id' => $user->id,
            'message' => $request->message,
        ]);

        return response()->json([
            'success' => true,
            'message' => $message,
        ]);
    }

    public function destroy(User $user, Message $message)
    {
        if ((int) Auth::id() !== (int) $message->sender_id) {
            return response()->json([
                'success' => false,
                'error' => 'Only the sender can delete this message.'
            ], 403);
        }

        $message->delete();

        return response()->json([
            'success' => true,
            'deleted_message_id' => $message->id,
        ]);
    }
}
