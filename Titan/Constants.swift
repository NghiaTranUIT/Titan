//
//  Constants.swift
//  Titan
//
//  Created by Nghia Tran Vinh on 9/25/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

struct Constants {
    
    //
    // MARK: - App
    struct App {
        static let Version = "1.0.0"
        static let isHTTPS = false
    }
    
    //
    // MARK: - Preference
    struct Preference {
        
        // Main app
        static let MainWindowFrame = NSRect(x: 100, y: 100, width: 1024, height: 768)
        static let DividerPosition: CGFloat = 260.0
        
        // Database
        static let DefaultLimitQuery: Int = 100
    }
    
    //
    // MARK: - Key
    struct Key {
        
        //
        // MARK: - Realm
        struct Realm {
            static let KeyChainID = "com.fe.titan.realm.pdoAR69Uv5WTseAhgA5va4eDONO9vgJOPV42DHFx"
        }
    }
    
    //
    // MARK: - Endpoint
    struct Endpoint {
        
        static let URLPrefix: String = {
            if Constants.App.isHTTPS {
                return "https://"
            }
            else {
                return "http://"
            }
        }()
        
        #if DEBUG // -> Development
        
        static let BaseURL: String = {
            
            if Constants.App.isHTTPS {
                return URLPrefix + "api.titan.com"
            }
            else {
                return URLPrefix + "159.203.246.136"
            }
            
        }()
        
        #else // -> Production
        
        static let BaseURL: String = {
        
            if Constants.App.isHTTPS {
                return URLPrefix + "api.titan.com"
            }
            else {
                return URLPrefix + "159.203.246.136"
            }
        
        }()
        
        #endif
        
        static let GetListConnectionFromCloudURL = "/connections"
        static let SaveObject = ""
    }
    
    //
    // MARK: - Logger
    struct Logger {
        
        // Slack
        struct Slack {
            static let Endpoint = "<Slack endpoint>"
            static let Token = "<Your token>"
            static let ErrorChannel = "<Error channel name>"
            static let ResponseChannel = "<Response channel name>"
            static let ResponseChannel_Webhook = "https://hooks.slack.com/services/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"
            static let ErrorChannel_Webhook = "https://hooks.slack.com/services/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"
        }
    }
    
    //
    // MARK: - Model
    struct Obj {
        
        //
        // MARK: - Base
        static let CreatedAt = "created_at"
        static let UpdatedAt = "updated_at"
        static let ObjectId = "objectId"
        static let KeyClassname = "c_n"
        static let IsProcess = "_is_procress"
        
        //
        // MARK: - Classname
        struct Classname {
            static let Database = "database"
        }
        
        //
        // MARK: - User
        struct User {
            static let GuestUserObjectId = "GuestUser"
            static let Username = "username"
            static let Setting = "setting"
            static let Database = "database"
        }
        
        
        //
        // MARK: - Database
        struct Database {
            static let Name = "name"
            static let Host = "host"
            static let User = "user"
            static let Password = "password"
            static let Database = "database"
            static let Port = "port"
            static let SaveToKeyChain = "save_to_keychain"
            static let ssl = "ssl"
            static let ssh = "ssh"
            static let groupConnection = "group_connection"
        }
        
        
        //
        // MARK: - Query
        struct Query {
            static let Name = "name"
            static let Content = "content"
        }
        
        
        //
        // MARK: - Setting
        struct Setting {
            static let AutomaticUpdate = "automatic_update"
            static let Version = "version"
        }
        
        //
        // MARK: - SSL
        struct SSL {
            static let ClientKeyFile = "client_key_file"
            static let ClientCertificate = "client_certificate"
            static let ServerRootCertificate = "server_root_certificate"
            static let CertificateRevocationList = "certificate_revocation_list"
            static let SSLCompression = "ssl_compression"
        }
        
        //
        // MARK: - SSH
        struct SSH {
            static let Host = "host"
            static let User = "user"
            static let IndentityFile = "indentity_file"
            static let Port = "port"
        }
        
        //
        // MARK: - Group Connection
        struct GroupConnection {
            static let Name = "name"
            static let Databases = "databases"
            static let Color = "color"
        }
    }
}
