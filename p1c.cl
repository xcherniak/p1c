-- main class 
class Main inherits IO {
    graph : AdjList <- new AdjNil;
    queue : List <- new Nil;
    read_input() : Object {
        
        
        let done : Bool <- false in
        --testTree : Tree <- new NilTree,
        --testList : List <- new Nil

        while not done loop 
            -- getting the child (first) and parent (second)
            -- need to figure out what to do with these - add to a data dtructure 
            -- I define, probably a type 
            -- this works for getting child and paretn and looping
            let child : String <- in_string(),
                parent : String <- in_string() in

            

            --testList <- testList.insert(child);
            --testList.print_list();

            if parent = "" then 
                done <- true
            else {
                graph <- graph.add_node(child);
                graph <- graph.add_node(parent);
                graph.insert_edge(parent, child);
            }
            fi
        pool  
    };

    bfs() : Object {
        -- pick something that hasn't been visited yet

    }

    main() : Object {
        {
            read_input();
            graph.print();
        }
    };
};

-- adjancey list classes 
Class AdjList inherits IO { 
    visitedtemp : Bool <- false;
    visitedperm : Bool <- false;

    cons(name : String, hd : List) : AdjCons {
        (new AdjCons).init(name, hd, self)
    };

    -- add a task in sorted order
    add_node(name : String) : AdjList {self};
    insert_edge(src : String, dest : String) : AdjList {self};
    length() : Int {0};
    get(name : String) : AdjList{self};

    get_visitedtemp() : Bool { visitedtemp };
    set_visitedtemp(p : Bool) : Bool { visitedtemp <- p };

    get_visitedperm() : Bool { visitedperm };
    set_visitedperm(p : Bool) : Bool {visitedperm <- p };
 
    print() : Object {true}; -- do nothing
};

Class AdjCons inherits AdjList {
    xname : String;
    xcar : List; -- adjacent tasks
    xcdr : AdjList;

 
    init(name : String, hd : List, tl : AdjList) : AdjCons {
        {
            xname <- name;
            xcar <- hd;
            xcdr <- tl;
            self;
        }
    };

    -- reverse insertion sort of a Set
    add_node(name : String) : AdjList {
        if xname = name then
            self
        else
            if xname < name then
                self.cons(name, new Nil) -- add our task at beginning with empty adj list
            else
                (new AdjCons).init(xname, xcar, xcdr.add_node(name))
            fi
        fi
    };

    insert_edge(src : String, dest : String) : AdjList {
        {
           if xname = src then
                xcar <- xcar.insert(dest)
            else
                xcdr <- xcdr.insert_edge(src, dest)
            fi;
            self;
        }
    };

    length() : Int { 
        1 + xcdr.length()
    };

    get(name : String) : AdjList {
        if xname = name then
            self
        else
            xcdr.get(name)
        fi
    };
 
    print() : Object {
        {
            out_string("-----\n");
            out_string(xname);
            out_string("\n adj: \n");
            xcar.print_list();
            out_string("\n");
            xcdr.print();
        }
    };
};

class AdjNil inherits AdjList {
    add_node (name : String) : AdjList {
        self.cons(name, new Nil) -- just add the task to the empty list and creat an empty adj list
    };
};

(*
-- really just have to make a tree 
-- can add things to it by going through and seeing if thigns are there, check
-- cycles and such that way too and can orginize by alphabetical order
 
-- tree will be a series of nodes 

class Tree inherits Cons {

 

    -- methods

    getElem() : String {

        getFirst(self)

    };

 

     -- adding a node, need to search the tree 

    newNodes(ch : String, pt : String) : Object {

        -- need to go through the tree and add in apporiate spot

        true -- do nothing

    };





};

 

class NilTree inherits Tree { 

    -- List { (new Cons).init(s,self) }; 

    addFirst(firstParent : String, firstChild : String) : Tree { (new ConsTree).init(firstParent, firstChild)};

};

 

class ConsTree inherits Tree { 

    -- atributes

    -- the tree is a list of nodes which are lists

    value : String;

    childern : List(Tree);

 

};

 

*)

 

-- make a list of most child nodes - first things you have to do, that are unconstrained to each

-- then make check each time if they are constriatned 

 

-- Node class for every node, cna maybe make two classes that inherit it f

(*

class Node inherits List { 

    -- attributes 

    data : String;

    parent : List;

    child : List; 

    

    -- methods

    const(data: String, parent: List, child: List) : Object {

        

        true

 

    };

 

   

 

};

 

*)





-- below is scopied from unsort 

(* The List type is not built in to Cool, so we'll have to define it 

 * ourselves. Cool classes can appear in any order, so we can define

* List here _after_ our reference to it in Main. *)

Class List inherits IO { 

        (* We only need three methods: cons, insert and print_list. *)
        (* cons appends returns a new list with 'hd' as the first
         * element and this list (self) as the rest of the list *)
    cons(hd : String) : Cons { 
      let new_cell : Cons <- new Cons in
        new_cell.init(hd,self)
    };

        (* You can think of List as an abstract interface that both
         * Cons and Nil (below) adhere to. Thus you're never supposed
         * to call insert() or print_list() on a List itself -- you're
         * supposed to build a Cons or Nil and do your work there. *)
    insert(i : String) : List { self };
    append(i : String) : List { self }; 
 

    print_list() : Object { abort() };

} ;

 

Class Cons inherits List { -- a Cons cell is a non-empty list 

    xcar : String;          -- xcar is the contents of the list head 

    xcdr : List;            -- xcdr is the rest of the list

 

    init(hd : String, tl : List) : Cons {

      {

        xcar <- hd;

        xcdr <- tl;

        self;

      }

    };

      

        (* insert() does insertion sort (using a reverse comparison) *)

    insert(s : String) : List {

        if not (s < xcar) then          -- sort in reverse order

            (new Cons).init(s,self)

        else

            (new Cons).init(xcar,xcdr.insert(s))

        fi

    };

    append(i : String) : List {
        (new Cons).init(xcar, xcdr.append(i))
    }

 

    print_list() : Object {

        {

             out_string(xcar);

             out_string("\n");

             xcdr.print_list();

        }

    };

} ;

 

Class Nil inherits List { -- Nil is an empty list 

 

    insert(s : String) : List { (new Cons).init(s,self) }; 

    append(i : String) : List { (new Cons).init(i,self) };
 

    print_list() : Object { true }; -- do nothing 

 

} ;